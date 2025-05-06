#lang forge

open "../types.frg"
open "../1vM.frg"

// ---- INCLUDE ABOVE ALWAYS, DO NOT CHANGE ----- //

// Top meta Pokémon from 2024 World Championships - Junior Division
// per https://www.pokemon.com/us/play-pokemon/worlds/2024/vgc-junior

// --------- NEW DECK: DEFINE POKEMON SIGS IN META -----------

one sig 
UrshifuWF,
RillaboomG,
CalyrexPI,
RagingBoltED,
FarigirafNP,
OgerponMaskGR
extends Pokemon {}

// --------- POKEMON SET: POPULATE WITH YOUR POKEMON ---------

fun metaSet: set Pokemon {
    UrshifuWF + RillaboomG + CalyrexPI + RagingBoltED + FarigirafNP + OgerponMaskGR
}

// ---------- POKEMON TYPES: SET UP DECK TYPES HERE ----------

pred setupMetaPokemon {
    // Top 6 most common Pokémon based on the quarterfinals teams and up

    // Urshifu (Water/Fighting) or (Dark/Fighting) - appeared in 7/8 teams
    // (Rapid Strike was more common, so using Water/Fighting typing)
    UrshifuWF.types = Water + Fighting
    
    // Rillaboom (Grass) - appeared in 6/8 teams
    RillaboomG.types = Grass
    
    // Calyrex (Psychic/Ice) or (Ghost/Psychic) - appeared in 5/8 teams 
    // (Ice Rider was more common, so using Psychic/Ice typing)
    CalyrexPI.types = Psychic + Ice
    
    // Raging Bolt (Electric/Dragon) - appeared in 5/8 teams
    RagingBoltED.types = Electric + Dragon
    
    // Farigiraf (Normal/Psychic) - appeared in 4/8 teams
    FarigirafNP.types = Normal + Psychic
    
    // Ogerpon with Mask (Grass/Rock) - appeared in 3/8 teams
    // (Cornerstone Mask was more common)
    OgerponMaskGR.types = Grass + Rock
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