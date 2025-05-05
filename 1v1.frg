#lang forge

open "types.frg"

abstract sig Bool {}
one sig True, False extends Bool {}


sig Pokemon {
    types: set Type, // one or two types
    attacking: one Bool
}

// --------- BATTLE PREDICATES ---------

pred isSuperEffectiveAgainst[ atkType:Type, defType:Type ]{
    defType in atkType.superEffectiveAgainst
}

pred isNotVeryEffectiveAgainst[ atkType:Type, defType:Type ]{
    defType in atkType.notVeryEffectiveAgainst
}

pred isNoEffectAgainst[ atkType:Type, defType:Type ]{
    defType in atkType.noEffectAgainst
}

// Case: x2 attack against one type, with no resistance/immunity on other type
pred normalNetSuperEffective[ attacker:Pokemon, defender:Pokemon ]{
    // just find ONE defType that is weak to the atkType
    some atkType : attacker.types | {
        some defType : defender.types | isSuperEffectiveAgainst[atkType,defType]
        all defType : defender.types | {
            not isNotVeryEffectiveAgainst[atkType,defType]
            not isNoEffectAgainst[atkType,defType]
        }
    }
    // note this can still generate compounded x4 attacks, but does not force it
}

// Case: x2 attack against both types
pred compoundedSuperEffective[ attacker:Pokemon, defender:Pokemon ]{
    // find BOTH defTypes that are weak to the atkType
    some atkType : attacker.types | {
        all defType : defender.types | isSuperEffectiveAgainst[atkType,defType]
    }
}

// Case: x2 attack against one type, x0.5 attack against the other type
pred hasNeutralization[attacker:Pokemon, defender:Pokemon] {
    some atkType : attacker.types, defType1, defType2 : defender.types | {
        isSuperEffectiveAgainst[atkType,defType1] and isNotVeryEffectiveAgainst[atkType,defType2]
    }
}

// Question about this below, "cancelling out the super effective" ==> how exactly
// To do: Add the more complex interactions described in the readme (particularly cancelling out the super effective)
// Simplified version that accounts for basic dual-type interactions
pred can1v1OHKO [attacker: Pokemon, defender: Pokemon]{
    normalNetSuperEffective[attacker, defender] or compoundedSuperEffective[attacker, defender]
    setPokemonAttackingStatus[attacker, defender]
}

// --------- SPECIFICATION PREDICATES ---------


// Helper pred to clarify which pokemon is attacking during can1v1OHKO and can2v2OHKO preds
pred setPokemonAttackingStatus[atkPok: Pokemon, defPok: Pokemon]{
    atkPok.attacking = True
    defPok.attacking = False
}


// --------- META POKEMON PREDICATES ---------

// Top meta Pokémon from World Championships - for reference
// per https://www.pokemon.com/us/play-pokemon/worlds/2024/vgc-masters
one sig MetaBreaker, Miraidon_ED, Ogerpon_G, 
    Farigiraf_NP, Calyrex_PI, Urshifu_WF extends Pokemon {}

// Setting up the meta Pokémon types
pred setupMetaPokemon {
    // Urshifu (Water/Fighting) - most common, appeared in 7/8 teams
    Urshifu_WF.types = Water + Fighting
    
    // Miraidon (Electric/Dragon) - appeared in 3/8 teams
    Miraidon_ED.types = Electric + Dragon
    
    // Ogerpon (Grass) - appeared in 4/8 teams
    Ogerpon_G.types = Grass
    
    // Farigiraf (Normal/Psychic) - appeared in 3/8 teams
    Farigiraf_NP.types = Normal + Psychic
    
    // Whimsicott (Grass/Fairy) - appeared in 2/8 teams
    // Whimsicott_GF.types = Grass + Fairy
    
    // Calyrex (Psychic/Ice) - appeared in 3/8 teams
    Calyrex_PI.types = Psychic + Ice
}

pred metaBreaker[breaker : Pokemon, metaPokemon: set Pokemon] {
    all metaPok : Pokemon | metaPok in metaPokemon implies {
        can1v1OHKO[breaker,metaPok]
    }
}


// --------- WELLFORMEDNESS PREDICATES ---------

// Enforces each pokemon has 1 or 2 types
pred numTypes {
    all pok : Pokemon | {
        #{pok.types} = 1 or #{pok.types} = 2
    }
}

pred attackerOnlyConstraint {
    all p: Pokemon | {
        p.attacking = True implies p = MetaBreaker
    }
}


// -------------- RUN PREDICATES ---------------
pred Battle1v1MetaBasic {
    typeProperties
    numTypes
    setupMetaPokemon
    metaBreaker[MetaBreaker, Miraidon_ED+Ogerpon_G+Farigiraf_NP+Calyrex_PI+Urshifu_WF]
}
// IMPORTANT NOTE:  ALL RUNS MUST BE DONE WITH AT LEAST 6 INT, SINCE THERE ARE 18 TYPES
//                  AND WE CANNOT ENFORCE 1 OR 2 MAX TYPES PER POKEMON WITHOUT OVERFLOW
//                  ISSUES IF WE DO NOT RUN WITH 6 INT (GETS US TO 31)
run Battle1v1MetaBasic for 6 Int
// run Battle1v1MaxCoverage for 6 Int
