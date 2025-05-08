#lang forge

open "types.frg"
open "2vM.frg"
open "2vMdecks/2vMtemplate.frg"

// -- wellformedness tests --
test suite for numTypes {
    // tests when a pokemon has 0 types (invalid)
    example noTypes is {not numTypes} for {
        Normal = `Normal
        Fire = `Fire
        Water = `Water
        Grass = `Grass
        Electric = `Electric
        Ice = `Ice
        Fighting = `Fighting
        Poison = `Poison
        Ground = `Ground
        Flying = `Flying
        Psychic = `Psychic
        Bug = `Bug
        Rock = `Rock
        Ghost = `Ghost
        Dragon = `Dragon
        Dark = `Dark
        Steel = `Steel
        Fairy = `Fairy
        Type = `Normal + `Fire + `Water + `Grass + `Electric + `Ice + `Fighting + `Poison + `Ground + `Flying + `Psychic + `Bug + `Rock + `Ghost + `Dragon + `Dark + `Steel + `Fairy

        MetaBreaker = `MetaBreaker
        MetaBreaker2 = `MetaBreaker2
        // placeholders required for 2vMtemplate.frg
        Placeholder1WR = `Placeholder1WR
        Placeholder2S = `Placeholder2S
        Placeholder3F = `Placeholder3F
        Placeholder4FG = `Placeholder4FG
        Placeholder5ND = `Placeholder5ND
        Placeholder6BI = `Placeholder6BI
        Pokemon = `p1 + `p2 + `MetaBreaker + `MetaBreaker2 + `Placeholder1WR + `Placeholder2S + `Placeholder3F + `Placeholder4FG + `Placeholder5ND + `Placeholder6BI
        `p2.types = `Normal
        `MetaBreaker.types = `Fire
        `MetaBreaker2.types = `Water
    }
    // tests when a pokemon has 3 types (invalid)
    example threeTypes_2vM is {not numTypes} for {
        Normal = `Normal
        Fire = `Fire
        Water = `Water
        Grass = `Grass
        Electric = `Electric
        Ice = `Ice
        Fighting = `Fighting
        Poison = `Poison
        Ground = `Ground
        Flying = `Flying
        Psychic = `Psychic
        Bug = `Bug
        Rock = `Rock
        Ghost = `Ghost
        Dragon = `Dragon
        Dark = `Dark
        Steel = `Steel
        Fairy = `Fairy
        Type = `Normal + `Fire + `Water + `Grass + `Electric + `Ice + `Fighting + `Poison + `Ground + `Flying + `Psychic + `Bug + `Rock + `Ghost + `Dragon + `Dark + `Steel + `Fairy

        MetaBreaker = `MetaBreaker
        MetaBreaker2 = `MetaBreaker2
        // placeholders required for 2vMtemplate.frg
        Placeholder1WR = `Placeholder1WR
        Placeholder2S = `Placeholder2S
        Placeholder3F = `Placeholder3F
        Placeholder4FG = `Placeholder4FG
        Placeholder5ND = `Placeholder5ND
        Placeholder6BI = `Placeholder6BI
        Pokemon = `p1 + `p2 + `MetaBreaker + `MetaBreaker2 + `Placeholder1WR + `Placeholder2S+  `Placeholder3F + `Placeholder4FG + `Placeholder5ND + `Placeholder6BI
        `p1.types = `Normal + `Fire + `Water
        `p2.types = `Normal
        `MetaBreaker.types = `Fire
        `MetaBreaker2.types = `Water
    }
    // tests when every pokemon has the correct num of types
    example correctTypes is {numTypes} for {
        Normal = `Normal
        Fire = `Fire
        Water = `Water
        Grass = `Grass
        Electric = `Electric
        Ice = `Ice
        Fighting = `Fighting
        Poison = `Poison
        Ground = `Ground
        Flying = `Flying
        Psychic = `Psychic
        Bug = `Bug
        Rock = `Rock
        Ghost = `Ghost
        Dragon = `Dragon
        Dark = `Dark
        Steel = `Steel
        Fairy = `Fairy
        Type = `Normal + `Fire + `Water + `Grass + `Electric + `Ice + `Fighting + `Poison + `Ground + `Flying + `Psychic + `Bug + `Rock + `Ghost + `Dragon + `Dark + `Steel + `Fairy

        MetaBreaker = `MetaBreaker
        MetaBreaker2 = `MetaBreaker2
        // placeholders required for 2vMtemplate.frg
        Placeholder1WR = `Placeholder1WR
        Placeholder2S = `Placeholder2S
        Placeholder3F = `Placeholder3F
        Placeholder4FG = `Placeholder4FG
        Placeholder5ND = `Placeholder5ND
        Placeholder6BI = `Placeholder6BI
        Pokemon = `p1 + `p2 + `MetaBreaker + `MetaBreaker2 + `Placeholder1WR + `Placeholder2S + `Placeholder3F + `Placeholder4FG + `Placeholder5ND + `Placeholder6BI
        `p1.types = `Fire + `Water // 2 types
        `p2.types = `Normal       // 1 type
        `MetaBreaker.types = `Grass
        `MetaBreaker2.types = `Electric + `Ice
    }
}

pred nonMetaBreakerAttacking {
    some p: Pokemon {
        p != MetaBreaker and p != MetaBreaker2
        p.attacking = True // This should be disallowed by setAttackingStatus
    }
}
test suite for Battle2vMeta {
    // makes sure non metabreakers are never attacking pokemon
    assert {nonMetaBreakerAttacking and Battle2vMeta[2]} is unsat
}

// -- battle tests are the same as in 1vM so no need to test --

// -- counter tests --
pred teamCountIs0_NoEffective {
    typeProperties
    numTypes
    MetaBreaker.types = Normal
    MetaBreaker2.types = Normal // Both breakers are Normal type

    some disj p_rock, p_ghost: Pokemon {
        // Ensure meta Pokemon are distinct and not the breakers
        p_rock != MetaBreaker and p_rock != MetaBreaker2 and
        p_ghost != MetaBreaker and p_ghost != MetaBreaker2

        p_rock.types = Rock
        p_ghost.types = Ghost
        breakerProperties[MetaBreaker, MetaBreaker2, p_rock + p_ghost]
        countTeamOHKOs[MetaBreaker, MetaBreaker2, p_rock + p_ghost] = 0
    }
}

pred teamCountIs1_OneBreakerEffective {
    typeProperties
    numTypes
    MetaBreaker.types = Fire
    MetaBreaker2.types = Water

    some disj p_grass, p_steel: Pokemon {
        p_grass != MetaBreaker and p_grass != MetaBreaker2 and
        p_steel != MetaBreaker and p_steel != MetaBreaker2

        p_grass.types = Grass  // Fire OHKOs Grass, Water resists Grass
        p_steel.types = Steel  // Fire SE vs Steel, Water NVE vs Steel
        p_grass.types = Grass
        
        breakerProperties[MetaBreaker, MetaBreaker2, p_grass]
        countTeamOHKOs[MetaBreaker, MetaBreaker2, p_grass] = 1
        
    }
}

pred teamCountIs2_BothEffectiveSeparately {
    typeProperties
    numTypes
    MetaBreaker.types = Fire
    MetaBreaker2.types = Water

    some disj p_grass, p_rock: Pokemon {
        p_grass != MetaBreaker and p_grass != MetaBreaker2 and
        p_rock != MetaBreaker and p_rock != MetaBreaker2 and
        p_grass != p_rock

        p_grass.types = Grass // Fire OHKOs Grass
        p_rock.types = Rock   // Water OHKOs Rock
        breakerProperties[MetaBreaker, MetaBreaker2, p_grass + p_rock]
        countTeamOHKOs[MetaBreaker, MetaBreaker2, p_grass + p_rock] = 2
        
    }
}

pred teamCountIs1_BothEffectiveSameTarget {
    typeProperties
    numTypes
    MetaBreaker.types = Fire
    MetaBreaker2.types = Ground

    some disj p_grass_steel: Pokemon {
        p_grass_steel != MetaBreaker and p_grass_steel != MetaBreaker2
        p_grass_steel.types = Grass + Steel // Fire OHKOs Grass/Steel, Ground OHKOs Grass/Steel
        breakerProperties[MetaBreaker, MetaBreaker2, p_grass_steel]
        countTeamOHKOs[MetaBreaker, MetaBreaker2, p_grass_steel] = 1
    }
}


test suite for countTeamOHKOs_2vM {
    assert teamCountIs0_NoEffective is sat
    assert teamCountIs1_OneBreakerEffective is sat
    assert teamCountIs2_BothEffectiveSeparately is sat
    assert teamCountIs1_BothEffectiveSameTarget is sat
}

// --- Tests for hasAtLeastNTeamOHKOsInSet ---
pred OHKOPossible1 {
    typeProperties
    numTypes
    MetaBreaker.types = Fire
    MetaBreaker2.types = Water
    some p_grass: Pokemon {
        p_grass != MetaBreaker and p_grass != MetaBreaker2
        p_grass.types = Grass
        breakerProperties[MetaBreaker, MetaBreaker2, p_grass]
        
        hasAtLeastNTeamOHKOsInSet[MetaBreaker, MetaBreaker2, p_grass, 1]
    }
}
pred not2OHKOsPossible {
    typeProperties
    numTypes
    MetaBreaker.types = Fire
    MetaBreaker2.types = Water
    some p_grass: Pokemon {
        p_grass != MetaBreaker and p_grass != MetaBreaker2
        p_grass.types = Grass
        breakerProperties[MetaBreaker, MetaBreaker2, p_grass]
        // countTeamOHKOs would be 1 here
        not hasAtLeastNTeamOHKOsInSet[MetaBreaker, MetaBreaker2, p_grass, 2] // N=2, should be false
    }
}
test suite for hasAtLeastNTeamOHKOsInSet {
    assert OHKOPossible1 is sat

    assert not2OHKOsPossible is sat
}
