#lang forge

open "../types.frg"
open "../2vM.frg"

// ---- INCLUDE ABOVE ALWAYS, DO NOT CHANGE ----- //

// --------- BELOW, NEW DECK: DEFINE POKEMON SIGS IN DECK -----------
// format: PokemonNameWR, where W and R are each the first initial of the
// pokemon's type(s). if the pokemon only has one type, just include the one.

one sig 

// Team 1 below
Placeholder1WR,
Placeholder2S,

// Team 2 below
Placeholder3F,
Placeholder4FG,

// Team 3 below
Placeholder5ND,
Placeholder6BI

extends Pokemon {}


// --------- POKEMON SET: POPULATE WITH YOUR POKEMON ---------
// add your pokemon into this func which creates a set of your pokemon.
// this func is used throughout the 2vM.frg logic so you must fill it.

fun metaSet: set Pokemon {
    // Team 1 below
    Placeholder1WR + Placeholder2S +

    // Team 2 below
    Placeholder3F + Placeholder4FG +

    // Team 3 below
    Placeholder5ND + Placeholder6BI
}


// ---------- POKEMON TYPES: SET UP DECK TYPES HERE ----------
// add types to your defined pokemon so we know what types they have
// format: PokemonName.types = TypeName1 + TypeName2IfApplicable

pred setupMetaPokemon {
    Placeholder1WR.types = Water + Rock
    Placeholder2S.types = Steel

    Placeholder3F.types = Fire
    Placeholder4FG.types = Fairy + Grass

    Placeholder5ND.types = Normal + Dark
    Placeholder6BI.types = Bug + Ice
}


// ------------- DO NOT TOUCH: BATTLE RUN PREDICATE --------------

pred Battle2vMeta [n : Int] {
    typeProperties
    numTypes
    setupMetaPokemon
    teamMetaBreaker[MetaBreaker, MetaBreaker2, metaSet, n]
    setAttackingStatus
}


// ----------------------- RUN YOUR DECK -------------------------
// TODO: replace "n" below with the # of pokemon the solver must beat in your deck
// Constraints: n !> |deck|, solver cannot beat more pokemon than in your deck itself

run { Battle2vMeta[n] } for 6 Int