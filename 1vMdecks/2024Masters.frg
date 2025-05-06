#lang forge

open "../types.frg"
open "../1vM.frg"

// ---- INCLUDE ABOVE ALWAYS, DO NOT CHANGE ----- //

// Top meta Pokémon from 2024 World Championships - Masters Division
// per https://www.pokemon.com/us/play-pokemon/worlds/2024/vgc-masters

// --------- NEW DECK: DEFINE POKEMON SIGS IN META -----------

one sig 
MiraidonED, 
OgerponTealG, 
FarigirafNP,
CalyrexPI,
UrshifuRapidStrikeWF,
WhimsicottGF
extends Pokemon {}


// --------- POKEMON SET: POPULATE WITH YOUR POKEMON ---------

fun metaSet: set Pokemon {
    MiraidonED + OgerponTealG + FarigirafNP + CalyrexPI + UrshifuRapidStrikeWF + WhimsicottGF
}


// ---------- POKEMON TYPES: SET UP DECK TYPES HERE ----------

pred setupMetaPokemon {
    // UrshifuRapidStrike (Water/Fighting) - most common, appeared in 7/8 teams
    UrshifuRapidStrikeWF.types = Water + Fighting
    
    // Miraidon (Electric/Dragon) - appeared in 3/8 teams
    MiraidonED.types = Electric + Dragon
    
    // Ogerpon (Grass) - appeared in 4/8 teams
    OgerponTealG.types = Grass
    
    // Farigiraf (Normal/Psychic) - appeared in 3/8 teams
    FarigirafNP.types = Normal + Psychic
    
    // Whimsicott (Grass/Fairy) - appeared in 2/8 teams
    WhimsicottGF.types = Grass + Fairy
    
    // Calyrex (Psychic/Ice) - appeared in 3/8 teams
    CalyrexPI.types = Psychic + Ice
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