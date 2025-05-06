#lang forge

open "types.frg"

abstract sig Bool {}
one sig True, False extends Bool {}


sig Pokemon {
    types: set Type, // one or two types
    attacking: one Bool
}

one sig MetaBreaker extends Pokemon {} // this is the solver's pokemon
one sig MetaBreaker2 extends Pokemon {}

one sig Count {
    count: one Int
}


// --------- NEW DECK: DEFINE POKEMON SIGS IN META -----------

one sig 
MiraidonED, 
OgerponTealG, 
FarigirafNP,
CalyrexPI,
UrshifuRapidStrikeWF,
WhimsicottGF
extends Pokemon {}


// --------- POKEMON SET: POPULATE WITH YOUR POKEMON ---------

fun metaSet: set Pokemon {
    MiraidonED + OgerponTealG + FarigirafNP + CalyrexPI + UrshifuRapidStrikeWF + WhimsicottGF
}


// ---------- POKEMON TYPES: SET UP DECK TYPES HERE ----------

pred setupMetaPokemon {
    // UrshifuRapidStrike (Water/Fighting) - most common, appeared in 7/8 teams
    UrshifuRapidStrikeWF.types = Water + Fighting
    
    // Miraidon (Electric/Dragon) - appeared in 3/8 teams
    MiraidonED.types = Electric + Dragon
    
    // Ogerpon (Grass) - appeared in 4/8 teams
    OgerponTealG.types = Grass
    
    // Farigiraf (Normal/Psychic) - appeared in 3/8 teams
    FarigirafNP.types = Normal + Psychic
    
    // Whimsicott (Grass/Fairy) - appeared in 2/8 teams
    WhimsicottGF.types = Grass + Fairy
    
    // Calyrex (Psychic/Ice) - appeared in 3/8 teams
    CalyrexPI.types = Psychic + Ice
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

// case: x2 attack against one type, with no resistance/immunity on other type
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

// case: x2 attack against both types
pred compoundedSuperEffective[ attacker:Pokemon, defender:Pokemon ]{
    // find BOTH defTypes that are weak to the atkType
    some atkType : attacker.types | {
        all defType : defender.types | isSuperEffectiveAgainst[atkType,defType]
    }
}

// case: x2 attack against one type, x0.5 attack against the other type
pred hasNeutralization[attacker:Pokemon, defender:Pokemon] {
    some atkType : attacker.types, defType1, defType2 : defender.types | {
        isSuperEffectiveAgainst[atkType,defType1] and isNotVeryEffectiveAgainst[atkType,defType2]
    }
}

// fundamental OHKO predicate that determines if a given pokemon can OHKO another
pred can1v1OHKO [attacker: Pokemon, defender: Pokemon]{
    normalNetSuperEffective[attacker, defender] or compoundedSuperEffective[attacker, defender]
    setPokemonAttackingStatus[attacker, defender]
}

// ------------ COUNTER PREDICATES ------------

fun countTeamOHKOs[breaker1: Pokemon, breaker2: Pokemon, metaPokemon: set Pokemon]: one Int {
    #{metaPok: Pokemon | metaPok in metaPokemon and 
      (can1v1OHKO[breaker1, metaPok] or can1v1OHKO[breaker2, metaPok])}
}


// used in maxFinder.frg to find the theoretical max number of OHKOs in a set
pred hasAtLeastNTeamOHKOsInSet[breaker1: Pokemon, breaker2: Pokemon, metaPokemon: set Pokemon, n: Int] {
    breaker1 not in metaPokemon
    breaker2 not in metaPokemon
    breaker1 != breaker2
    countTeamOHKOs[breaker1, breaker2, metaPokemon] >= n
}

// used in runs to find all instances of types against a given meta that will deliver n KOs
pred teamMetaBreaker[breaker1: Pokemon, breaker2: Pokemon, metaPokemon: set Pokemon, nKOs: Int] {
    breaker1 != breaker2
    breaker1 not in metaPokemon
    breaker2 not in metaPokemon
    
    countTeamOHKOs[breaker1, breaker2, metaPokemon] = nKOs
    
    all otherBreaker1, otherBreaker2: Pokemon | {
        (otherBreaker1 != breaker1 or otherBreaker2 != breaker2) and
        otherBreaker1 != otherBreaker2 and
        otherBreaker1 not in metaPokemon and 
        otherBreaker2 not in metaPokemon
        implies
        countTeamOHKOs[otherBreaker1, otherBreaker2, metaPokemon] <= nKOs
    }
    
    Count.count = nKOs
}


// --------- SPECIFICATION PREDICATES ---------

// Helper pred to clarify which pokemon is attacking during can1v1OHKO and can2v2OHKO preds
pred setPokemonAttackingStatus[atkPok: Pokemon, defPok: Pokemon]{
    atkPok.attacking = True
    defPok.attacking = False
}


// --------- WELLFORMEDNESS PREDICATES ---------

// Enforces each pokemon has 1 or 2 types
pred numTypes {
    all pok : Pokemon | {
        #{pok.types} = 1 or #{pok.types} = 2
    }
}

pred setAttackingStatus {
    all p: Pokemon | {
        p.attacking = True implies (p = MetaBreaker or p = MetaBreaker2)
    }
}





// ---------------------- RUN PREDICATES ------------------------
// note: code below will not run and does not do anything, only for visual reference

pred Battle2v6Meta [n : Int] {
    typeProperties
    numTypes
    setupMetaPokemon
    teamMetaBreaker[MetaBreaker, MetaBreaker2, metaSet, n]
    setAttackingStatus
}

// IMPORTANT NOTE:  ALL RUNS MUST BE DONE WITH AT LEAST 6 INT, SINCE THERE ARE 18 TYPES
//                  AND WE CANNOT ENFORCE 1 OR 2 MAX TYPES PER POKEMON WITHOUT OVERFLOW
//                  ISSUES IF WE DO NOT RUN WITH 6 INT (GETS US TO 31)
run {Battle2v6Meta[6]} for 6 Int