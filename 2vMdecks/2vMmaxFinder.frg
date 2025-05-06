#lang forge

// ---------------- ADD DECK HERE ----------------- //
open "2vMdecks/RandomMassiveMeta.frg"
// --- otherwise it's not visible to the finder --- //

open "types.frg"
open "2vM.frg"

test expect {
    setupAndTypes: {
        typeProperties
        numTypes
        setupMetaPokemon
    } for 6 Int is sat

    // // is there a meta-breaking pair of pokemon that can OHKO at least 1 meta Pokémon?
    // maxIs1: {
    //     typeProperties
    //     numTypes
    //     setupMetaPokemon
    //     some disj breaker1,breaker2: Pokemon | {
    //         breaker1 not in metaSet and breaker2 not in metaSet
    //         hasAtLeastNTeamOHKOsInSet[breaker1,breaker2,metaSet,1]
    //     }
    // } for 6 Int is sat

    // // is there a meta-breaking pair of pokemon that can OHKO at least 2 meta Pokémon?
    // maxIs2: {
    //     typeProperties
    //     numTypes
    //     setupMetaPokemon
    //     some disj breaker1,breaker2: Pokemon | {
    //         breaker1 not in metaSet and breaker2 not in metaSet
    //         hasAtLeastNTeamOHKOsInSet[breaker1,breaker2,metaSet,2]
    //     }
    // } for 6 Int is sat

    // // is there a meta-breaking pair of pokemon that can OHKO at least 3 meta Pokémon?
    // maxIs3: {
    //     typeProperties
    //     numTypes
    //     setupMetaPokemon
    //     some disj breaker1,breaker2: Pokemon | {
    //         breaker1 not in metaSet and breaker2 not in metaSet
    //         hasAtLeastNTeamOHKOsInSet[breaker1,breaker2,metaSet,3]
    //     }
    // } for 6 Int is sat

    // // is there a meta-breaking pair of pokemon that can OHKO at least 4 meta Pokémon?
    // maxIs4: {
    //     typeProperties
    //     numTypes
    //     setupMetaPokemon
    //     some disj breaker1,breaker2: Pokemon | {
    //         breaker1 not in metaSet and breaker2 not in metaSet
    //         hasAtLeastNTeamOHKOsInSet[breaker1,breaker2,metaSet,4]
    //     }
    // } for 6 Int is sat

    // // is there a meta-breaking pokemon that can OHKO all 5 meta Pokémon?
    // maxIs5: {
    //     typeProperties
    //     numTypes
    //     setupMetaPokemon
    //     some disj breaker1,breaker2: Pokemon | {
    //         breaker1 not in metaSet and breaker2 not in metaSet
    //         hasAtLeastNTeamOHKOsInSet[breaker1,breaker2,metaSet,5]
    //     }
    // } for 6 Int is sat

    // // is there a meta-breaking pokemon that can OHKO all 6 meta Pokémon?
    // maxIs6: {
    //     typeProperties
    //     numTypes
    //     setupMetaPokemon
    //     some disj breaker1,breaker2: Pokemon | {
    //         breaker1 not in metaSet and breaker2 not in metaSet
    //         hasAtLeastNTeamOHKOsInSet[breaker1,breaker2,metaSet,6]
    //     }
    // } for 6 Int is sat

    // // is there a meta-breaking pair of pokemon that can OHKO at least 7 meta Pokémon?
    // maxIs7: {
    //     typeProperties
    //     numTypes
    //     setupMetaPokemon
    //     some disj breaker1,breaker2: Pokemon | {
    //         breaker1 not in metaSet and breaker2 not in metaSet
    //         hasAtLeastNTeamOHKOsInSet[breaker1,breaker2,metaSet,7]
    //     }
    // } for 6 Int is sat

    // // is there a meta-breaking pair of pokemon that can OHKO at least 8 meta Pokémon?
    // maxIs8: {
    //     typeProperties
    //     numTypes
    //     setupMetaPokemon
    //     some disj breaker1,breaker2: Pokemon | {
    //         breaker1 not in metaSet and breaker2 not in metaSet
    //         hasAtLeastNTeamOHKOsInSet[breaker1,breaker2,metaSet,8]
    //     }
    // } for 6 Int is sat

    // // is there a meta-breaking pair of pokemon that can OHKO at least 9 meta Pokémon?
    // maxIs9: {
    //     typeProperties
    //     numTypes
    //     setupMetaPokemon
    //     some disj breaker1,breaker2: Pokemon | {
    //         breaker1 not in metaSet and breaker2 not in metaSet
    //         hasAtLeastNTeamOHKOsInSet[breaker1,breaker2,metaSet,9]
    //     }
    // } for 6 Int is sat

    // // is there a meta-breaking pair of pokemon that can OHKO at least 10 meta Pokémon?
    // maxIs10: {
    //     typeProperties
    //     numTypes
    //     setupMetaPokemon
    //     some disj breaker1,breaker2: Pokemon | {
    //         breaker1 not in metaSet and breaker2 not in metaSet
    //         hasAtLeastNTeamOHKOsInSet[breaker1,breaker2,metaSet,10]
    //     }
    // } for 6 Int is sat

    // // is there a meta-breaking pair of pokemon that can OHKO at least 11 meta Pokémon?
    // maxIs11: {
    //     typeProperties
    //     numTypes
    //     setupMetaPokemon
    //     some disj breaker1,breaker2: Pokemon | {
    //         breaker1 not in metaSet and breaker2 not in metaSet
    //         hasAtLeastNTeamOHKOsInSet[breaker1,breaker2,metaSet,11]
    //     }
    // } for 6 Int is sat


    // // is there a meta-breaking pair of pokemon that can OHKO at least 12 meta Pokémon?
    // maxIs12: {
    //     typeProperties
    //     numTypes
    //     setupMetaPokemon
    //     some disj breaker1,breaker2: Pokemon | {
    //         breaker1 not in metaSet and breaker2 not in metaSet
    //         hasAtLeastNTeamOHKOsInSet[breaker1,breaker2,metaSet,12]
    //     }
    // } for 6 Int is sat

    // // is there a meta-breaking pair of pokemon that can OHKO at least 13 meta Pokémon?
    // maxIs13: {
    //     typeProperties
    //     numTypes
    //     setupMetaPokemon
    //     some disj breaker1,breaker2: Pokemon | {
    //         breaker1 not in metaSet and breaker2 not in metaSet
    //         hasAtLeastNTeamOHKOsInSet[breaker1,breaker2,metaSet,13]
    //     }
    // } for 6 Int is sat

    // // is there a meta-breaking pair of pokemon that can OHKO at least 14 meta Pokémon?
    // maxIs14: {
    //     typeProperties
    //     numTypes
    //     setupMetaPokemon
    //     some disj breaker1,breaker2: Pokemon | {
    //         breaker1 not in metaSet and breaker2 not in metaSet
    //         hasAtLeastNTeamOHKOsInSet[breaker1,breaker2,metaSet,14]
    //     }
    // } for 6 Int is sat

    // // is there a meta-breaking pair of pokemon that can OHKO at least 15 meta Pokémon?
    // maxIs15: {
    //     typeProperties
    //     numTypes
    //     setupMetaPokemon
    //     some disj breaker1,breaker2: Pokemon | {
    //         breaker1 not in metaSet and breaker2 not in metaSet
    //         hasAtLeastNTeamOHKOsInSet[breaker1,breaker2,metaSet,15]
    //     }
    // } for 6 Int is sat

    // // is there a meta-breaking pair of pokemon that can OHKO at least 16 meta Pokémon?
    // maxIs16: {
    //     typeProperties
    //     numTypes
    //     setupMetaPokemon
    //     some disj breaker1,breaker2: Pokemon | {
    //         breaker1 not in metaSet and breaker2 not in metaSet
    //         hasAtLeastNTeamOHKOsInSet[breaker1,breaker2,metaSet,16]
    //     }
    // } for 6 Int is sat

    // // is there a meta-breaking pair of pokemon that can OHKO at least 17 meta Pokémon?
    // maxIs17: {
    //     typeProperties
    //     numTypes
    //     setupMetaPokemon
    //     some disj breaker1,breaker2: Pokemon | {
    //         breaker1 not in metaSet and breaker2 not in metaSet
    //         hasAtLeastNTeamOHKOsInSet[breaker1,breaker2,metaSet,17]
    //     }
    // } for 6 Int is sat

    // // is there a meta-breaking pair of pokemon that can OHKO at least 18 meta Pokémon?
    // maxIs18: {
    //     typeProperties
    //     numTypes
    //     setupMetaPokemon
    //     some disj breaker1,breaker2: Pokemon | {
    //         breaker1 not in metaSet and breaker2 not in metaSet
    //         hasAtLeastNTeamOHKOsInSet[breaker1,breaker2,metaSet,18]
    //     }
    // } for 6 Int is sat

    // // is there a meta-breaking pair of pokemon that can OHKO at least 19 meta Pokémon?
    // maxIs19: {
    //     typeProperties
    //     numTypes
    //     setupMetaPokemon
    //     some disj breaker1,breaker2: Pokemon | {
    //         breaker1 not in metaSet and breaker2 not in metaSet
    //         hasAtLeastNTeamOHKOsInSet[breaker1,breaker2,metaSet,19]
    //     }
    // } for 6 Int is sat

    // // is there a meta-breaking pair of pokemon that can OHKO at least 20 meta Pokémon?
    // maxIs20: {
    //     typeProperties
    //     numTypes
    //     setupMetaPokemon
    //     some disj breaker1,breaker2: Pokemon | {
    //         breaker1 not in metaSet and breaker2 not in metaSet
    //         hasAtLeastNTeamOHKOsInSet[breaker1,breaker2,metaSet,20]
    //     }
    // } for 6 Int is sat

    // is there a meta-breaking pair of pokemon that can OHKO at least 21 meta Pokémon?
    maxIs21: {
        typeProperties
        numTypes
        setupMetaPokemon
        some disj breaker1,breaker2: Pokemon | {
            breaker1 not in metaSet and breaker2 not in metaSet
            hasAtLeastNTeamOHKOsInSet[breaker1,breaker2,metaSet,21]
        }
    } for 6 Int is sat

    // is there a meta-breaking pair of pokemon that can OHKO at least 22 meta Pokémon?
    maxIs22: {
        typeProperties
        numTypes
        setupMetaPokemon
        some disj breaker1,breaker2: Pokemon | {
            breaker1 not in metaSet and breaker2 not in metaSet
            hasAtLeastNTeamOHKOsInSet[breaker1,breaker2,metaSet,22]
        }
    } for 6 Int is sat
    
    // is there a meta-breaking pair of pokemon that can OHKO at least 23 meta Pokémon?
    maxIs23: {
        typeProperties
        numTypes
        setupMetaPokemon
        some disj breaker1,breaker2: Pokemon | {
            breaker1 not in metaSet and breaker2 not in metaSet
            hasAtLeastNTeamOHKOsInSet[breaker1,breaker2,metaSet,23]
        }
    } for 6 Int is sat

    // is there a meta-breaking pair of pokemon that can OHKO at least 24 meta Pokémon?
    maxIs24: {
        typeProperties
        numTypes
        setupMetaPokemon
        some disj breaker1,breaker2: Pokemon | {
            breaker1 not in metaSet and breaker2 not in metaSet
            hasAtLeastNTeamOHKOsInSet[breaker1,breaker2,metaSet,24]
        }
    } for 6 Int is sat

    // is there a meta-breaking pair of pokemon that can OHKO at least 25 meta Pokémon?
    maxIs25: {
        typeProperties
        numTypes
        setupMetaPokemon
        some disj breaker1,breaker2: Pokemon | {
            breaker1 not in metaSet and breaker2 not in metaSet
            hasAtLeastNTeamOHKOsInSet[breaker1,breaker2,metaSet,25]
        }
    } for 6 Int is sat

    // is there a meta-breaking pair of pokemon that can OHKO at least 26 meta Pokémon?
    maxIs26: {
        typeProperties
        numTypes
        setupMetaPokemon
        some disj breaker1,breaker2: Pokemon | {
            breaker1 not in metaSet and breaker2 not in metaSet
            hasAtLeastNTeamOHKOsInSet[breaker1,breaker2,metaSet,26]
        }
    } for 6 Int is sat

    // NOTE: we may need to add more for VERY NARROW cases where metas are a) massive and b) have insane overlap, but I don't foresee this
}
