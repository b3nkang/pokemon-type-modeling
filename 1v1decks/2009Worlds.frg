#lang forge

open "../types.frg"
open "../1v1.frg"

// ---- INCLUDE ABOVE ALWAYS, DO NOT CHANGE ----- //

// 2009 Pokémon World Championship - First ever Worlds
// Won by Kazuyuki Tsuji of Japan
// https://www.nimbasacitypost.com/2009/08/world-championships-2009.html


// --------- NEW DECK: DEFINE POKEMON SIGS IN META -----------

one sig 
ToxicroakPF,
SalamenceDFl,
LudicoloWG,
MetagrossSPs,
EmpoleonWS,
SnorlaxN
extends Pokemon {}

// --------- POKEMON SET: POPULATE WITH YOUR POKEMON ---------

fun metaSet: set Pokemon {
    ToxicroakPF + SalamenceDFl + LudicoloWG + MetagrossSPs + EmpoleonWS + SnorlaxN
}

// ---------- POKEMON TYPES: SET UP DECK TYPES HERE ----------

pred setupMetaPokemon {
    // Kazuyuki Tsuji's winning team from the first World Championship

    // Toxicroak (Poison/Fighting)
    ToxicroakPF.types = Poison + Fighting
    
    // Salamence (Dragon/Flying)
    SalamenceDFl.types = Dragon + Flying
    
    // Ludicolo (Water/Grass) - Key rain team Pokémon
    LudicoloWG.types = Water + Grass
    
    // Metagross (Steel/Psychic)
    MetagrossSPs.types = Steel + Psychic
    
    // Empoleon (Water/Steel)
    EmpoleonWS.types = Water + Steel
    
    // Snorlax (Normal)
    SnorlaxN.types = Normal
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
// (just supply the # of pokemon the solver must beat in the meta)

run { Battle1v1Meta[5] } for 6 Int