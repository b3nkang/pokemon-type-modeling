#lang forge

open "types.frg"


test suite for main {
    example simpleOHKOScenario is {main} for {
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
        Pokemon = `P1 + `P2 + `P3 + `P4
        Team = `T1 + `T2

        // -- Pokemon types (satisfies numTypes) --
        types = `P1 -> `Fire +
                `P2 -> `Water +
                `P3 -> `Grass +
                `P4 -> `Fire

        // -- Team members (satisfies teamSize) --
        members = `T1 -> (`P1 + `P2) +
                  `T2 -> (`P3 + `P4)

        // Type Effectiveness Relations
        superEffectiveAgainst =
            `Fire -> (`Grass + `Bug + `Ice + `Steel) +
            `Water -> (`Fire + `Ground + `Rock) +
            `Electric -> (`Water + `Flying) +
            `Grass -> (`Water + `Ground + `Rock) +
            `Ice -> (`Grass + `Ground + `Flying + `Dragon) +
            `Fighting -> (`Normal + `Rock + `Steel + `Ice + `Dark) +
            `Poison -> (`Grass + `Fairy) +
            `Ground -> (`Fire + `Electric + `Poison + `Rock + `Steel) +
            `Flying -> (`Grass + `Fighting + `Bug) +
            `Psychic -> (`Fighting + `Poison) +
            `Bug -> (`Grass + `Psychic + `Dark) +
            `Rock -> (`Fire + `Ice + `Flying + `Bug) +
            `Ghost -> (`Psychic + `Ghost) +
            `Dragon -> `Dragon +
            `Dark -> (`Psychic + `Ghost) +
            `Steel -> (`Ice + `Rock + `Fairy) +
            `Fairy -> (`Fighting + `Dragon + `Dark)

        notVeryEffectiveAgainst =
            `Normal -> (`Rock + `Steel) +
            `Fire -> (`Fire + `Water + `Rock + `Dragon) +
            `Water -> (`Water + `Grass + `Dragon) +
            `Electric -> (`Electric + `Grass + `Dragon) +
            `Grass -> (`Fire + `Grass + `Poison + `Flying + `Bug + `Dragon + `Steel) +
            `Ice -> (`Fire + `Water + `Ice + `Steel) +
            `Fighting -> (`Poison + `Flying + `Psychic + `Bug + `Fairy) +
            `Poison -> (`Poison + `Ground + `Rock + `Ghost) +
            `Ground -> (`Grass + `Bug) +
            `Flying -> (`Electric + `Rock + `Steel) +
            `Psychic -> (`Psychic + `Steel) +
            `Bug -> (`Fire + `Fighting + `Poison + `Flying + `Ghost + `Steel + `Fairy) +
            `Rock -> (`Fighting + `Ground + `Steel) +
            `Ghost -> `Dark +
            `Dragon -> `Steel +
            `Dark -> (`Fighting + `Bug + `Fairy) +
            `Steel -> (`Fire + `Water + `Electric + `Steel) +
            `Fairy -> (`Fire + `Poison + `Steel)

        noEffectAgainst =
            `Normal -> `Ghost +
            `Electric -> `Ground +
            `Fighting -> `Ghost +
            `Poison -> `Steel +
            `Ground -> `Flying +
            `Psychic -> `Dark +
            `Ghost -> `Normal +
            `Dragon -> `Fairy
    }
}