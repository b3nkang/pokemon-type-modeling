#lang forge

open "types.frg"
open "1vM.frg"
open "1vMdecks/1vMtemplate.frg" // for Battle1v1Meta pred. Should generalize as this template is used in all decks

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
        // placeholders required for 1vMtemplate.frg
        Placeholder1WR = `Placeholder1WR
        Placeholder2S = `Placeholder2S
        Pokemon = `p1 + `p2 + `MetaBreaker + `Placeholder1WR + `Placeholder2S
        `p1.types = `Normal + `Fire
    }
    // tests when a pokemon has 3 types (invalid)
    example threeTypes is {not numTypes} for {
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
        Placeholder1WR = `Placeholder1WR
        Placeholder2S = `Placeholder2S
        Pokemon = `p1 + `p2 + `MetaBreaker + `Placeholder1WR + `Placeholder2S
        `p1.types = `Normal + `Fire + `Water
        `p2.types = `Normal
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
        Placeholder1WR = `Placeholder1WR
        Placeholder2S = `Placeholder2S
        Pokemon = `p1 + `p2 + `MetaBreaker + `Placeholder1WR + `Placeholder2S
        
        `p1.types = `Fire + `Water
        `p2.types = `Normal
    }
}
// metabreaker is always an attacking pokemon
pred alwaysAttacking {
    all p: Pokemon|{
        p = MetaBreaker implies p.attacking = True
    }
}
test suite for Battle1v1Meta {
    // makes sure metabreakers are always attacking in a battle
    assert Battle1v1Meta[2] is sufficient for alwaysAttacking
}
pred nonMetaBreakerIsActuallyAttacking {
    typeProperties
    some p: Pokemon {
        p != MetaBreaker
        p.types = Fire // Arbitrary types
        MetaBreaker.types = Water
        p.attacking = True
    }
}
test suite for setAttackingStatus {
    assert {nonMetaBreakerIsActuallyAttacking and setAttackingStatus} is unsat
}

// -- battle tests --
pred groundVSFlyingElectric[attacker:Pokemon, defender:Pokemon] {
    typeProperties
    attacker.types = Ground
    defender.types = Flying + Electric
    // no other pokemon
    all p: Pokemon | {
        p = attacker or p = defender
    }
}
pred fireVSGrassIce[attacker:Pokemon, defender:Pokemon]{
    typeProperties
    attacker.types = Fire
    defender.types = Grass + Bug
    // no other pokemon
    all p: Pokemon | {
        p = attacker or p = defender
    }
}
pred waterGrassVSFire[attacker:Pokemon, defender:Pokemon]{
    typeProperties
    attacker.types = Water + Grass
    defender.types = Fire
    // no other pokemon
    all p: Pokemon | {
        p = attacker or p = defender
    }
}
pred fireVSGrassFlying[attacker: Pokemon, defender: Pokemon] { 
    typeProperties
    attacker.types = Fire
    defender.types = Grass + Flying 
    // no other pokemon
    all p: Pokemon | {
        p = attacker or p = defender
    }
}
pred notcan1v1OHKO[attacker, defender: Pokemon]{
    not can1v1OHKO[attacker, defender]
}
test suite for can1v1OHKO {
    // when attacker is super effective against one of the defender's type but another defender type grants immunity,
    // attacker should not be able to OHKO
    assert all disj attacker, defender:Pokemon | groundVSFlyingElectric[attacker, defender] is sufficient for notcan1v1OHKO[attacker, defender]
    
    // when attacker is super effective against both of the defender's types, attacker should OHKO
    assert all disj attacker, defender:Pokemon | fireVSGrassIce[attacker, defender] is sufficient for can1v1OHKO[attacker, defender]

    // when attacker has two types and one of the types is super effective and the other is not effective,
    // the supereffective type should be used for an OHKO
    assert all disj attacker, defender: Pokemon | waterGrassVSFire[attacker, defender] is sufficient for can1v1OHKO[attacker, defender]

    // when attacker's type is super effective against one of the defenders types and isn't resisted/immune by the other defender type,
    // should OHKO
    assert all disj attacker, defender: Pokemon | fireVSGrassFlying[attacker, defender] is sufficient for can1v1OHKO[attacker, defender]
}


// -- counter tests --
pred countOHKOsIs0 {
    MetaBreaker.types = Normal
}
pred countOHKOsIs1 {
    typeProperties
    numTypes
    MetaBreaker.types = Fire
    some disj p_grass, p_water: Pokemon {
        p_grass != MetaBreaker and p_water != MetaBreaker
        p_grass.types = Grass
        p_water.types = Water
        countOHKOs[MetaBreaker, p_grass + p_water] = 1 // Fire OHKOs Grass, not Water
    }
}
pred countOHKOsIs2 {
    typeProperties
    numTypes
    MetaBreaker.types = Ground
    some disj p_fire, p_rock: Pokemon {
        p_fire != MetaBreaker and p_rock != MetaBreaker
        p_fire.types = Fire
        p_rock.types = Rock
        let meta = p_fire + p_rock {
            countOHKOs[MetaBreaker, meta] = 2 // Ground OHKOs Fire and Rock
        }
    }
}
test suite for countOHKOs {
    // test count is 0 when MetaBreaker isn't supereffective
    assert countOHKOsIs0 is sat
    // test count is 1 when MetaBreaker OHKOs one pokemon in the meta but not the other
    assert countOHKOsIs1 is sat
    // test count is 2 when MetaBreaker OHKOs both pokemon in the meta
    assert countOHKOsIs2 is sat
}
pred metaBreakerN1 {
    typeProperties
    numTypes
    setAttackingStatus
    MetaBreaker.types = Fire
    #{Pokemon} = 4
    some disj meta_grass, meta_water, other_pok_normal: Pokemon {
        meta_grass != MetaBreaker and meta_water != MetaBreaker and other_pok_normal != MetaBreaker

        meta_grass.types = Grass
        meta_water.types = Water
        other_pok_normal.types = Normal

        // MetaBreaker gets 1 KO
        countOHKOs[MetaBreaker, meta_grass + meta_water] = 1
        // other_pok_normal gets 0 KO
        countOHKOs[other_pok_normal, meta_grass + meta_water] = 0

        // metaBreaker should hold
        metaBreaker[MetaBreaker, meta_grass + meta_water, 1]
    }
}

test suite for metaBreaker {
    // test that metaBreaker can find a MetaBreaker with at least 1 OHKO
    assert metaBreakerN1 is sat
}