#lang forge

open "../types.frg"
open "../1vM.frg"

// ---- INCLUDE ABOVE ALWAYS, DO NOT CHANGE ----- //

// Top meta Pokémon from 2024 World Championships - Senior Division
// per https://www.pokemon.com/us/play-pokemon/worlds/2024/vgc-senior

// --------- NEW DECK: DEFINE POKEMON SIGS IN META -----------

one sig 
UrshifuRapidStrikeWF,
RillaboomG,
AmoongussGP,
RagingBoltED,
CalyrexPI,
FarigirafNP
extends Pokemon {}

// --------- POKEMON SET: POPULATE WITH YOUR POKEMON ---------

fun metaSet: set Pokemon {
    UrshifuRapidStrikeWF + RillaboomG + AmoongussGP + RagingBoltED + CalyrexPI + FarigirafNP
}

// ---------- POKEMON TYPES: SET UP DECK TYPES HERE ----------

pred setupMetaPokemon {
    // Top 6 most common Pokémon based on the quarterfinals teams and up

    // Urshifu Rapid Strike (Water/Fighting) - appeared in 6/8 teams
    UrshifuRapidStrikeWF.types = Water + Fighting
    
    // Rillaboom (Grass) - appeared in 4/8 teams
    RillaboomG.types = Grass
    
    // Amoonguss (Grass/Poison) - appeared in 3/8 teams
    AmoongussGP.types = Grass + Poison
    
    // Raging Bolt (Electric/Dragon) - appeared in 5/8 teams
    RagingBoltED.types = Electric + Dragon
    
    // Calyrex (Psychic/Ice) - appeared in 3/8 teams
    CalyrexPI.types = Psychic + Ice
    
    // Farigiraf (Normal/Psychic) - appeared in 3/8 teams 
    FarigirafNP.types = Normal + Psychic
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