#lang forge

open "types.frg"
open "1v1.frg"

test expect {
    setupAndTypes: {
        typeProperties
        numTypes
        setupMetaPokemon
    } for 6 Int is sat

    // // is there a meta-breaking pokemon that can OHKO at least 1 meta Pokémon?
    // maxIs1: {
    //     typeProperties
    //     numTypes
    //     setupMetaPokemon
    //     some breaker: Pokemon | {
    //         breaker not in metaSet
    //         hasAtLeastNOHKOsInSet[breaker, metaSet, 1]
    //     }
    // } for 6 Int is sat

    // // is there a meta-breaking pokemon that can OHKO at least 2 meta Pokémon?
    // maxIs2: {
    //     typeProperties
    //     numTypes
    //     setupMetaPokemon
    //     some breaker: Pokemon | {
    //         breaker not in metaSet
    //         hasAtLeastNOHKOsInSet[breaker, metaSet, 2]
    //     }
    // } for 6 Int is sat

    // // is there a meta-breaking pokemon that can OHKO at least 3 meta Pokémon?
    // maxIs3: {
    //     typeProperties
    //     numTypes
    //     setupMetaPokemon
    //     some breaker: Pokemon | {
    //         breaker not in metaSet
    //         hasAtLeastNOHKOsInSet[breaker, metaSet, 3]
    //     }
    // } for 6 Int is sat

    // // is there a meta-breaking pokemon that can OHKO at least 4 meta Pokémon?
    // maxIs4: {
    //     typeProperties
    //     numTypes
    //     setupMetaPokemon
    //     some breaker: Pokemon | {
    //         breaker not in metaSet
    //         hasAtLeastNOHKOsInSet[breaker, metaSet, 4]
    //     }
    // } for 6 Int is sat

    // is there a meta-breaking pokemon that can OHKO all 5 meta Pokémon?
    maxIs5: {
        typeProperties
        numTypes
        setupMetaPokemon
        some breaker: Pokemon | {
            breaker not in metaSet
            hasAtLeastNOHKOsInSet[breaker, metaSet, 5]
        }
    } for 6 Int is sat

    // is there a meta-breaking pokemon that can OHKO all 6 meta Pokémon?
    maxIs6: {
        typeProperties
        numTypes
        setupMetaPokemon
        some breaker: Pokemon | {
            breaker not in metaSet
            hasAtLeastNOHKOsInSet[breaker, metaSet, 6]
        }
    } for 6 Int is sat

    // is there a meta-breaking pokemon that can OHKO at least 7 meta Pokémon?
    maxIs7: {
        typeProperties
        numTypes
        setupMetaPokemon
        some breaker: Pokemon | {
            breaker not in metaSet
            hasAtLeastNOHKOsInSet[breaker, metaSet, 7]
        }
    } for 6 Int is sat

    // is there a meta-breaking pokemon that can OHKO at least 8 meta Pokémon?
    maxIs8: {
        typeProperties
        numTypes
        setupMetaPokemon
        some breaker: Pokemon | {
            breaker not in metaSet
            hasAtLeastNOHKOsInSet[breaker, metaSet, 8]
        }
    } for 6 Int is sat

    // is there a meta-breaking pokemon that can OHKO at least 9 meta Pokémon?
    maxIs9: {
        typeProperties
        numTypes
        setupMetaPokemon
        some breaker: Pokemon | {
            breaker not in metaSet
            hasAtLeastNOHKOsInSet[breaker, metaSet, 9]
        }
    } for 6 Int is sat

    // is there a meta-breaking pokemon that can OHKO at least 10 meta Pokémon?
    maxIs10: {
        typeProperties
        numTypes
        setupMetaPokemon
        some breaker: Pokemon | {
            breaker not in metaSet
            hasAtLeastNOHKOsInSet[breaker, metaSet, 10]
        }
    } for 6 Int is sat

    // is there a meta-breaking pokemon that can OHKO at least 11 meta Pokémon?
    maxIs11: {
        typeProperties
        numTypes
        setupMetaPokemon
        some breaker: Pokemon | {
            breaker not in metaSet
            hasAtLeastNOHKOsInSet[breaker, metaSet, 11]
        }
    } for 6 Int is sat


    // is there a meta-breaking pokemon that can OHKO at least 12 meta Pokémon?
    maxIs12: {
        typeProperties
        numTypes
        setupMetaPokemon
        some breaker: Pokemon | {
            breaker not in metaSet
            hasAtLeastNOHKOsInSet[breaker, metaSet, 12]
        }
    } for 6 Int is sat
}
