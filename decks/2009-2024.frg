#lang forge

open "../types.frg"
open "../1v1.frg"

// ---- INCLUDE ABOVE ALWAYS, DO NOT CHANGE ----- //

// Combined 2009 World Championship and 2024 Masters teams
// 2009 was the first ever World Championship, won by Kazuyuki Tsuji
// 2024 represents modern competitive VGC meta

// --------- NEW DECK: DEFINE POKEMON SIGS IN META -----------

one sig 
// 2009 World Championship Team
Worlds2009_ToxicroakPF,
Worlds2009_SalamenceDFl,
Worlds2009_LudicoloWG,
Worlds2009_MetagrossSPs,
Worlds2009_EmpoleonWS,
Worlds2009_SnorlaxN,
// 2024 Masters Team
Masters2024_UrshifuRapidStrikeWF,
Masters2024_RillaboomG,
Masters2024_AmoongussGP,
Masters2024_RagingBoltED,
Masters2024_CalyrexPI,
Masters2024_FarigirafNP
extends Pokemon {}

// --------- POKEMON SET: POPULATE WITH YOUR POKEMON ---------

fun metaSet: set Pokemon {
    // 2009 World Championship Team
    Worlds2009_ToxicroakPF + Worlds2009_SalamenceDFl + Worlds2009_LudicoloWG + 
    Worlds2009_MetagrossSPs + Worlds2009_EmpoleonWS + Worlds2009_SnorlaxN +
    // 2024 Masters Team
    Masters2024_UrshifuRapidStrikeWF + Masters2024_RillaboomG + Masters2024_AmoongussGP + 
    Masters2024_RagingBoltED + Masters2024_CalyrexPI + Masters2024_FarigirafNP
}

// ---------- POKEMON TYPES: SET UP DECK TYPES HERE ----------

pred setupMetaPokemon {
    // --- 2009 World Championship Pokémon ---
    
    // Toxicroak (Poison/Fighting)
    Worlds2009_ToxicroakPF.types = Poison + Fighting
    
    // Salamence (Dragon/Flying)
    Worlds2009_SalamenceDFl.types = Dragon + Flying
    
    // Ludicolo (Water/Grass) - Key rain team Pokémon
    Worlds2009_LudicoloWG.types = Water + Grass
    
    // Metagross (Steel/Psychic)
    Worlds2009_MetagrossSPs.types = Steel + Psychic
    
    // Empoleon (Water/Steel)
    Worlds2009_EmpoleonWS.types = Water + Steel
    
    // Snorlax (Normal)
    Worlds2009_SnorlaxN.types = Normal
    
    // --- 2024 Masters Division Pokémon ---
    
    // Urshifu Rapid Strike (Water/Fighting) - appeared in 6/8 teams
    Masters2024_UrshifuRapidStrikeWF.types = Water + Fighting
    
    // Rillaboom (Grass) - appeared in 4/8 teams
    Masters2024_RillaboomG.types = Grass
    
    // Amoonguss (Grass/Poison) - appeared in 3/8 teams
    Masters2024_AmoongussGP.types = Grass + Poison
    
    // Raging Bolt (Electric/Dragon) - appeared in 5/8 teams
    Masters2024_RagingBoltED.types = Electric + Dragon
    
    // Calyrex (Psychic/Ice) - appeared in 3/8 teams
    Masters2024_CalyrexPI.types = Psychic + Ice
    
    // Farigiraf (Normal/Psychic) - appeared in 3/8 teams 
    Masters2024_FarigirafNP.types = Normal + Psychic
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