#lang forge

abstract sig Type {
    superEffectiveAgainst: set Type,    // 2x damage
    notVeryEffectiveAgainst: set Type,  // 0.5x damage
    noEffectAgainst: set Type,           // 0x damage  
    score: one Int
}

one sig Normal, Fire, Water, Grass, Electric, Ice, Fighting, Poison,
    Ground, Flying, Psychic, Bug, Rock, Ghost, Dragon, Dark, Steel,
    Fairy extends Type {}

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