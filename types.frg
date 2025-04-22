#lang forge

abstract sig Type {
    superEffectiveAgainst: set Type,    // 2x damage
    notVeryEffectiveAgainst: set Type,  // 0.5x damage
    noEffectAgainst: set Type,          // 0x damage  
}

one sig Normal, Fire, Water, Grass, Electric, Ice, Fighting, Poison,
    Ground, Flying, Psychic, Bug, Rock, Ghost, Dragon, Dark, Steel,
    Fairy extends Type {}

pred normalTypeProperties() {
    Normal.superEffectiveAgainst = none
    Normal.notVeryEffectiveAgainst = set { Rock, Steel }
    Normal.noEffectAgainst = set { Ghost }
}
pred fireTypeProperties() {
    Fire.superEffectiveAgainst = set { Grass, Bug, Ice, Steel }
    Fire.notVeryEffectiveAgainst = set { Fire, Water, Rock, Dragon }
    Fire.noEffectAgainst = none
}
pred waterTypeProperties() {
    Water.superEffectiveAgainst = set { Fire, Ground, Rock }
    Water.notVeryEffectiveAgainst = set { Water, Grass, Dragon }
    Water.noEffectAgainst = none
}
pred electricTypeProperties() {
    Electric.superEffectiveAgainst = set { Water, Flying }
    Electric.notVeryEffectiveAgainst = set { Electric, Gras, Dragon }
    Electric.noEffectAgainst = set { Ground }
}
pred grassTypeProperties() {
    Grass.superEffectiveAgainst = set { Water, Ground, Rock }
    Grass.notVeryEffectiveAgainst = set { Fire, Grass, Poison, Flying, Bug, Dragon, Steel }
    Grass.noEffectAgainst = none
}
pred iceTypeProperties() {
    Ice.superEffectiveAgainst = set { Grass, Ground, Flying, Dragon }
    Ice.notVeryEffectiveAgainst = set { Fire, Water, Ice, Steel }
    Ice.noEffectAgainst = none
}
pred fightingTypeProperties() {
    Fighting.superEffectiveAgainst = set { Normal, Ice, Rock, Dark, Steel }
    Fighting.notVeryEffectiveAgainst = set { Poison, Flying, Psychic, Bug, Fairy }
    Fighting.noEffectAgainst = set { Ghost }
}
pred poisonTypeProperties() {
    Poison.superEffectiveAgainst = set { Grass, Fairy }
    Poison.notVeryEffectiveAgainst = set { Poison, Ground, Rock, Ghost }
    Poison.noEffectAgainst = set { Steel }
}
pred groundTypeProperties() {
    Ground.superEffectiveAgainst = set { Fire, Electric, Poison, Rock, Steel }
    Ground.notVeryEffectiveAgainst = set { Grass, Bug }
    Ground.noEffectAgainst = set { Flying }
}
pred flyingTypeProperties() {
    Flying.superEffectiveAgainst = set { Grass, Fighting, Bug }
    Flying.notVeryEffectiveAgainst = set { Electric, Rock, Steel }
    Flying.noEffectAgainst = none
}
pred psychicTypeProperties() {
    Psychic.superEffectiveAgainst = set { Fighting, Poison }
    Psychic.notVeryEffectiveAgainst = set { Psychic, Steel }
    Psychic.noEffectAgainst = set { Dark }
}
pred bugTypeProperties() {
    Bug.superEffectiveAgainst = set { Grass, Psychic, Dark }
    Bug.notVeryEffectiveAgainst = set { Fire, Fighting, Poison, Flying, Ghost, Steel, Fairy }
    Bug.noEffectAgainst = none
}
pred rockTypeProperties() {
    Rock.superEffectiveAgainst = set { Fire, Ice, Flying, Bug }
    Rock.notVeryEffectiveAgainst = set { Fighting, Ground, Steel }
    Rock.noEffectAgainst = none
}
pred ghostTypeProperties() {
    Ghost.superEffectiveAgainst = set { Psychic, Ghost }
    Ghost.notVeryEffectiveAgainst = set { Dark }
    Ghost.noEffectAgainst = set { Normal }
}
pred dragonTypeProperties() {
    Dragon.superEffectiveAgainst = set { Dragon }
    Dragon.notVeryEffectiveAgainst = set { Steel }
    Dragon.noEffectAgainst = set { Fairy }
}
pred darkTypeProperties() {
    Dark.superEffectiveAgainst = set { Psychic, Ghost }
    Dark.notVeryEffectiveAgainst = set { Fighting, Dark, Fairy }
    Dark.noEffectAgainst = none
}
pred steelTypeProperties() {
    Steel.superEffectiveAgainst = set { Ice, Rock, Fairy }
    Steel.notVeryEffectiveAgainst = set { Fire, Water, Electric, Steel }
    Steel.noEffectAgainst = none
}
pred fairyTypeProperties() {
    Fairy.superEffectiveAgainst = set { Fighting, Dragon, Dark }
    Fairy.notVeryEffectiveAgainst = set { Fire, Poison, Steel }
    Fairy.noEffectAgainst = none
}
pred typeProperties() {
    normalTypeProperties()
    fireTypeProperties()
    waterTypeProperties()
    grassTypeProperties()
    electricTypeProperties()
    iceTypeProperties()
    fightingTypeProperties()
    poisonTypeProperties()
    groundTypeProperties()
    flyingTypeProperties()
    psychicTypeProperties()
    bugTypeProperties()
    rockTypeProperties()
    ghostTypeProperties()
    dragonTypeProperties()
    darkTypeProperties()
    steelTypeProperties()
    fairyTypeProperties()
}