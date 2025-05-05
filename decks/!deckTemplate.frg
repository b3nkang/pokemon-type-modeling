#lang forge

open "../types.frg"
open "../1v1.frg"

// ---- INCLUDE ABOVE ALWAYS, DO NOT CHANGE ----- //

// --------- BELOW, NEW DECK: DEFINE POKEMON SIGS IN DECK -----------
// format: PokemonNameWF, where W and F are each the first initial of the
// pokemon's type(s). if the pokemon only has one type, just include the one.

one sig 
Placeholder1WR,
Placeholder2S
extends Pokemon {}


// --------- POKEMON SET: POPULATE WITH YOUR POKEMON ---------
// add your pokemon into this func which creates a set of your pokemon.
// this func is used throughout the 1v1.frg logic so you must fill it.

fun metaSet: set Pokemon {
    Placeholder1WR + Placeholder2S
}


// ---------- POKEMON TYPES: SET UP DECK TYPES HERE ----------
// add types to your defined pokemon so we know what types they have
// format: PokemonName.types = TypeName1 + TypeName2IfApplicable

pred setupMetaPokemon {
    Placeholder1WR.types = Water + Rock
    Placeholder2S.types = Steel
}


// ------------- DO NOT TOUCH: BATTLE RUN PREDICATE --------------

pred Battle1v1Meta [n : Int] {
    typeProperties
    numTypes
    setupMetaPokemon
    metaBreaker[MetaBreaker,metaSet,n]
    setAttackingStatus
}


// ----------------------- RUN YOUR DECK -------------------------
// TODO: replace "n" below with the # of pokemon the solver must beat in your deck
// Constraints: n !> |deck|, solver cannot beat more pokemon than in your deck itself

run { Battle1v1Meta[n] } for 6 Int