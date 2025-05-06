#lang forge

open "../types.frg"
open "../1v1.frg"

// ---- INCLUDE ABOVE ALWAYS, DO NOT CHANGE ----- //

// Combined meta Pokémon from 2024 World Championships
// Junior and Masters Divisions

// --------- NEW DECK: DEFINE POKEMON SIGS IN META -----------

one sig 
// Juniors
Juniors_UrshifuWF,
Juniors_RillaboomG,
Juniors_CalyrexPI,
Juniors_RagingBoltED,
Juniors_FarigirafNP,
Juniors_OgerponMaskGR,
// Masters
Masters_MiraidonED, 
Masters_OgerponTealG,
Masters_FarigirafNP,
Masters_CalyrexPI,
Masters_UrshifuRapidStrikeWF,
Masters_WhimsicottGF
extends Pokemon {}

// --------- POKEMON SET: POPULATE WITH YOUR POKEMON ---------

fun metaSet: set Pokemon {
    // Juniors
    Juniors_UrshifuWF + Juniors_RillaboomG + Juniors_CalyrexPI + 
    Juniors_RagingBoltED + Juniors_FarigirafNP + Juniors_OgerponMaskGR +
    // Masters
    Masters_MiraidonED + Masters_OgerponTealG + Masters_FarigirafNP + 
    Masters_CalyrexPI + Masters_UrshifuRapidStrikeWF + Masters_WhimsicottGF
}

// ---------- POKEMON TYPES: SET UP DECK TYPES HERE ----------

pred setupMetaPokemon {
    // --- Junior Division Pokémon ---
    
    // Urshifu (Water/Fighting) - appeared in 7/8 Junior teams
    Juniors_UrshifuWF.types = Water + Fighting
    
    // Rillaboom (Grass) - appeared in 6/8 Junior teams
    Juniors_RillaboomG.types = Grass
    
    // Calyrex Ice Rider (Psychic/Ice) - appeared in 5/8 Junior teams
    Juniors_CalyrexPI.types = Psychic + Ice
    
    // Raging Bolt (Electric/Dragon) - appeared in 5/8 Junior teams
    Juniors_RagingBoltED.types = Electric + Dragon
    
    // Farigiraf (Normal/Psychic) - appeared in 4/8 Junior teams
    Juniors_FarigirafNP.types = Normal + Psychic
    
    // Ogerpon with Mask (Grass/Rock) - appeared in 3/8 Junior teams
    Juniors_OgerponMaskGR.types = Grass + Rock
    
    // --- Masters Division Pokémon ---
    
    // Urshifu Rapid Strike (Water/Fighting) - most common in Masters
    Masters_UrshifuRapidStrikeWF.types = Water + Fighting
    
    // Miraidon (Electric/Dragon) - appeared in 3/8 Masters teams
    Masters_MiraidonED.types = Electric + Dragon
    
    // Ogerpon (Grass) - appeared in 4/8 Masters teams
    Masters_OgerponTealG.types = Grass
    
    // Farigiraf (Normal/Psychic) - appeared in 3/8 Masters teams
    Masters_FarigirafNP.types = Normal + Psychic
    
    // Whimsicott (Grass/Fairy) - appeared in 2/8 Masters teams
    Masters_WhimsicottGF.types = Grass + Fairy
    
    // Calyrex (Psychic/Ice) - appeared in 3/8 Masters teams
    Masters_CalyrexPI.types = Psychic + Ice
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

run { Battle1v1Meta[10] } for 6 Int