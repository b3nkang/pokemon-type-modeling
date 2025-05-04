#lang forge

open "types.frg"

abstract sig Bool {}
one sig True, False extends Bool {}

sig Pokemon {
    types: set Type, // one or two types
    attacking: one Bool
}

sig Team {
    members: set Pokemon
}

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

// Implement compounded weakness
// ==> Implement instance generation given two defender types (done)

// Implement compounded resistance (??)
// Implement immunity (??)
// ==> Implement instance generation given two attacker types (done)

// Implement counts based on characteristics of types, such as:
    // type coverage count, then find best coverage (most hits against super effective)
    // type weakness count, then find least weaknesses
    // net effective weakness count, then find best net
// ==> use best characteristic preds ALONGSIDE instance generation given two pokemon to find edge cases

// an extension: implement intelligent OHKO with turns possibly


// New updated version: there is no 1-to-2 mapping where 1 attacker can OHKO 2 defenders, since at a minimum we should enforce each pokemon moves once bc of "speed"
// Checks if the attacking team can OHKO the defending team
pred can2v2OHKO [attackingTeam: Team, defendingTeam: Team]{
    some disj defPok1, defPok2: Pokemon | {
        defendingTeam.members = defPok1 + defPok2
        some disj atkPok1, atkPok2: Pokemon | {
            attackingTeam.members = atkPok1 + atkPok2
            (can1v1OHKO[atkPok1,defPok1] and can1v1OHKO[atkPok2,defPok2]) or (can1v1OHKO[atkPok1,defPok2] and can1v1OHKO[atkPok2,defPok1])
        }
    }
}

// Checks if the attacking team can OHKO the entire defending team
pred oldCan2v2OHKO [attackingTeam: Team, defendingTeam: Team]{
    all defPok: Pokemon | {
        defPok in defendingTeam.members implies {
            some atkPok: Pokemon | {
                atkPok in attackingTeam.members
                can1v1OHKO[atkPok,defPok]
            }
        }
    }
}

// --------- SPECIFICATION PREDICATES ---------

// Helper pred for solver to find matchups given BOTH pokemon on a team
// Can also find one addition type of pokemon if FindAdditionalType is True
// Note: findAdditionalType should only be True if at least one of the pokemon ONLY has 1 type, but if not, it will still work
pred setBothPokemonOnTeam[team: Team, p1Types: set Type, p2Types: set Type, findAdditionalType: Bool]{
    // must be different pokemon
    some disj pok1, pok2: Pokemon | {
        team.members = pok1 + pok2 

        findAdditionalType = True implies {
            applyFindAdditionalType[p1Types,pok1]
            applyFindAdditionalType[p2Types,pok2]
        }
        findAdditionalType = False implies {
            pok1.types = p1Types
            pok2.types = p2Types
        }
    }
}

// Helper pred for solver to find matchups given ONE pokemon on a DEFENDING team
// Can also find one addition type of pokemon if FindAdditionalType is True
// Note: findAdditionalType should only be True if at least one of the pokemon ONLY has 1 type, but if not, it will still work
pred setOnePokemonOnTeam[team: Team, pokTypes: Type, findAdditionalType: Bool]{
    // set the types of the pokemon in the defending team
    some pok : Pokemon | {
        team.members & pok = pok
        findAdditionalType = True implies {
            applyFindAdditionalType[pokTypes,pok]
        }
        findAdditionalType = False implies {
            pok.types = pokTypes
        }
    }
}

// Helper for logic if FindAdditionalType is specified for setting team preds
pred applyFindAdditionalType[pokTypes: set Type, pok : Pokemon]{
    #{pokTypes} = 1 implies {
        some type: Type | {
            type & pokTypes = none
            pok.types = type + pokTypes
        }
    }
    #{pokTypes} = 2 implies {
        pok.types = pokTypes
    }
}

// Helper pred to clarify which pokemon is attacking during can1v1OHKO and can2v2OHKO preds
pred setPokemonAttackingStatus[atkPok: Pokemon, defPok: Pokemon]{
    atkPok.attacking = True
    defPok.attacking = False
}


// --------- META POKEMON PREDICATES ---------

// Top meta Pokémon from World Championships - for reference
// per https://www.pokemon.com/us/play-pokemon/worlds/2024/vgc-masters
one sig MetaBreaker, Miraidon_ED, Ogerpon_G, 
    Whimsicott_GF, Calyrex_PI extends Pokemon {}

// Setting up the meta Pokémon types
pred setupMetaPokemon {
    // Urshifu (Water/Fighting) - most common, appeared in 7/8 teams
    // Urshifu_WF.types = Water + Fighting
    
    // Miraidon (Electric/Dragon) - appeared in 3/8 teams
    Miraidon_ED.types = Electric + Dragon
    
    // Ogerpon (Grass) - appeared in 4/8 teams
    Ogerpon_G.types = Grass
    
    // Farigiraf (Normal/Psychic) - appeared in 3/8 teams
    // Farigiraf_NP.types = Normal + Psychic
    
    // Whimsicott (Grass/Fairy) - appeared in 2/8 teams
    Whimsicott_GF.types = Grass + Fairy
    
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

// Enforces well-formed teams
pred teamProperties {
    // each team has 2 pokemon
    all t : Team | {
        #{t.members} = 2
    }

    // teams are unique
    all disj t1, t2: Team | {
        t1.members & t2.members = none
    }

    // each pok must belong to exactly one team
    all pok: Pokemon | one t: Team | pok in t.members

    // only two teams
    #Team = 2
}

// -------------- RUN PREDICATES ---------------
pred Battle2v2 {
    typeProperties
    some disj atkTeam,defTeam : Team | {
        can2v2OHKO[atkTeam,defTeam]
        setBothPokemonOnTeam[defTeam, Bug + Steel, Dark + Poison, False]
    }
    numTypes
    teamProperties
} 

pred Battle1v1Meta {
    typeProperties
    numTypes
    setupMetaPokemon
    // some metaBreakerPok : Pokemon | { metaBreaker[metaBreakerPok,Urshifu_WF+Miraidon_ED+Ogerpon_G+Farigiraf_NP+Whimsicott_GF+Calyrex_PI] }
    // some metaBreakerPok : Pokemon | { metaBreaker[metaBreakerPok,Miraidon_ED+Ogerpon_G+Whimsicott_GF+Calyrex_PI] }
    metaBreaker[MetaBreaker, Miraidon_ED+Ogerpon_G+Whimsicott_GF+Calyrex_PI]

}

// IMPORTANT NOTE:  ALL RUNS MUST BE DONE WITH AT LEAST 6 INT, SINCE THERE ARE 18 TYPES
//                  AND WE CANNOT ENFORCE 1 OR 2 MAX TYPES PER POKEMON WITHOUT OVERFLOW
//                  ISSUES IF WE DO NOT RUN WITH 6 INT (GETS US TO 31)
// run Battle2v2 for 6 Int
run Battle1v1Meta for 6 Int