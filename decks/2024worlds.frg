#lang forge

open "../types.frg"
open "../1v1.frg"

// ---- INCLUDE ABOVE ALWAYS, DO NOT CHANGE ----- //

// Top meta Pokémon from World Championships - for reference
// per https://www.pokemon.com/us/play-pokemon/worlds/2024/vgc-masters

// --------- NEW DECK: DEFINE POKEMON SIGS IN META -----------

one sig 
Miraidon_ED, 
Ogerpon_G, 
Farigiraf_NP,
Calyrex_PI,
Urshifu_WF,
Whimsicott_GF
extends Pokemon {}


// --------- POKEMON SET: POPULATE WITH YOUR POKEMON ---------

fun metaSet: set Pokemon {
    Miraidon_ED + Ogerpon_G + Farigiraf_NP + Calyrex_PI + Urshifu_WF + Whimsicott_GF
}


// ---------- POKEMON TYPES: SET UP DECK TYPES HERE ----------

pred setupMetaPokemon {
    // Urshifu (Water/Fighting) - most common, appeared in 7/8 teams
    Urshifu_WF.types = Water + Fighting
    
    // Miraidon (Electric/Dragon) - appeared in 3/8 teams
    Miraidon_ED.types = Electric + Dragon
    
    // Ogerpon (Grass) - appeared in 4/8 teams
    Ogerpon_G.types = Grass
    
    // Farigiraf (Normal/Psychic) - appeared in 3/8 teams
    Farigiraf_NP.types = Normal + Psychic
    
    // Whimsicott (Grass/Fairy) - appeared in 2/8 teams
    Whimsicott_GF.types = Grass + Fairy
    
    // Calyrex (Psychic/Ice) - appeared in 3/8 teams
    Calyrex_PI.types = Psychic + Ice
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