#lang forge

abstract sig Bool {}
one sig True, False extends Bool {}

abstract sig Type {
    superEffectiveAgainst: set Type,    // 2x damage
    notVeryEffectiveAgainst: set Type,  // 0.5x damage
    noEffectAgainst: set Type           // 0x damage  
}

one sig Normal, Fire, Water, Grass, Electric, Ice, Fighting, Poison,
    Ground, Flying, Psychic, Bug, Rock, Ghost, Dragon, Dark, Steel,
    Fairy extends Type {}

sig Pokemon {
    types: set Type, // one or two types
    attacking: one Bool
}

sig Team {
    members: set Pokemon
}

pred normalTypeProperties {
    Normal.superEffectiveAgainst = none
    Normal.notVeryEffectiveAgainst = Rock + Steel
    Normal.noEffectAgainst = Ghost
}
pred fireTypeProperties {
    Fire.superEffectiveAgainst = Grass + Bug + Ice + Steel
    Fire.notVeryEffectiveAgainst = Fire + Water + Rock + Dragon
    Fire.noEffectAgainst = none
}
pred waterTypeProperties {
    Water.superEffectiveAgainst = Fire + Ground + Rock
    Water.notVeryEffectiveAgainst = Water + Grass + Dragon
    Water.noEffectAgainst = none
}
pred electricTypeProperties {
    Electric.superEffectiveAgainst = Water + Flying
    Electric.notVeryEffectiveAgainst = Electric + Grass + Dragon
    Electric.noEffectAgainst = Ground
}
pred grassTypeProperties {
    Grass.superEffectiveAgainst = Water + Ground + Rock
    Grass.notVeryEffectiveAgainst = Fire + Grass + Poison + Flying + Bug + Dragon + Steel
    Grass.noEffectAgainst = none
}
pred iceTypeProperties {
    Ice.superEffectiveAgainst = Grass + Ground + Flying + Dragon
    Ice.notVeryEffectiveAgainst = Fire + Water + Ice + Steel
    Ice.noEffectAgainst = none
}
pred fightingTypeProperties {
    Fighting.superEffectiveAgainst = Normal + Rock + Steel + Ice + Dark
    Fighting.notVeryEffectiveAgainst = Poison + Flying + Psychic + Bug + Fairy
    Fighting.noEffectAgainst = Ghost
}
pred poisonTypeProperties {
    Poison.superEffectiveAgainst = Grass + Fairy
    Poison.notVeryEffectiveAgainst = Poison + Ground + Rock + Ghost
    Poison.noEffectAgainst = Steel
}
pred groundTypeProperties {
    Ground.superEffectiveAgainst = Fire + Electric + Poison + Rock + Steel
    Ground.notVeryEffectiveAgainst = Grass + Bug
    Ground.noEffectAgainst = Flying
}
pred flyingTypeProperties {
    Flying.superEffectiveAgainst = Grass + Fighting + Bug
    Flying.notVeryEffectiveAgainst = Electric + Rock + Steel
    Flying.noEffectAgainst = none
}
pred psychicTypeProperties {
    Psychic.superEffectiveAgainst = Fighting + Poison
    Psychic.notVeryEffectiveAgainst = Psychic + Steel
    Psychic.noEffectAgainst = Dark
}
pred bugTypeProperties {
    Bug.superEffectiveAgainst = Grass + Psychic + Dark
    Bug.notVeryEffectiveAgainst = Fire + Fighting + Poison + Flying + Ghost + Steel + Fairy
    Bug.noEffectAgainst = none
}
pred rockTypeProperties {
    Rock.superEffectiveAgainst = Fire + Ice + Flying + Bug
    Rock.notVeryEffectiveAgainst = Fighting + Ground + Steel
    Rock.noEffectAgainst = none
}
pred ghostTypeProperties {
    Ghost.superEffectiveAgainst = Psychic + Ghost
    Ghost.notVeryEffectiveAgainst = Dark
    Ghost.noEffectAgainst = Normal
}
pred dragonTypeProperties {
    Dragon.superEffectiveAgainst = Dragon
    Dragon.notVeryEffectiveAgainst = Steel
    Dragon.noEffectAgainst = Fairy
}
pred darkTypeProperties {
    Dark.superEffectiveAgainst = Psychic + Ghost
    Dark.notVeryEffectiveAgainst = Fighting + Bug + Fairy
    Dark.noEffectAgainst = none
}
pred steelTypeProperties {
    Steel.superEffectiveAgainst = Ice + Rock + Fairy
    Steel.notVeryEffectiveAgainst = Fire + Water + Electric + Steel
    Steel.noEffectAgainst = none
}
pred fairyTypeProperties {
    Fairy.superEffectiveAgainst = Fighting + Dragon + Dark
    Fairy.notVeryEffectiveAgainst = Fire + Poison + Steel
    Fairy.noEffectAgainst = none
}
pred typeProperties {
    normalTypeProperties
    fireTypeProperties
    waterTypeProperties
    grassTypeProperties
    electricTypeProperties
    iceTypeProperties
    fightingTypeProperties
    poisonTypeProperties
    groundTypeProperties
    flyingTypeProperties
    psychicTypeProperties
    bugTypeProperties
    rockTypeProperties
    ghostTypeProperties
    dragonTypeProperties
    darkTypeProperties
    steelTypeProperties
    fairyTypeProperties
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
pred canOHKO [attacker: Pokemon, defender: Pokemon]{
    some atkType : attacker.types | {
        // Attack is super-effective against at least one type
        some defType : defender.types | defType in atkType.superEffectiveAgainst
        
        // No defending type provides immunity
        all defType : defender.types | defType not in atkType.noEffectAgainst
        
        // No defending type cuts the effect in half
        
        all defType : defender.types | defType not in atkType.notVeryEffectiveAgainst
    }
}

// Checks if the attacking team can OHKO the entire defending team
pred canFullyOHKO [attackingTeam: Team, defendingTeam: Team]{
    all def: Pokemon | {
        def in defendingTeam.members implies {
            some atk: Pokemon | {
                atk in attackingTeam.members
                canOHKO[atk, def]
            }
        }
    }
}

// Enforces each pokemon has 1 or 2 types
pred numTypes {
    all pok : Pokemon | {
        #{pok.types} = 1 or #{pok.types} = 2
    }
}

// Enforces team sizes
pred teamSize {
    all t : Team | {
        #{t.members} = 2
    }
}

pred main {
    typeProperties
    some t1, t2 : Team | {
        canFullyOHKO[t1,t2]
    }
    numTypes
    teamSize
}

run main