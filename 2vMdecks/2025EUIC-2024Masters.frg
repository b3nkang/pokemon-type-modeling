#lang forge

open "../types.frg"
open "../2vM.frg"

// ---- INCLUDE ABOVE ALWAYS, DO NOT CHANGE ----- //

// Combined meta Pokémon from 2024 World Championships Masters Division
// and the 2025 EU International Championships Masters Division

// --------- NEW DECK: DEFINE POKEMON SIGS IN META -----------

one sig 

// 2024 Worlds - Meta
MiraidonED, 
OgerponTealG, 
FarigirafNP,
CalyrexPI,
UrshifuRapidStrikeWF,
WhimsicottGF,

// 2025 EUIC - Meta
UrshifuWF,
IncineroarFD,
AmoongussGP,
RillaboomG,
OgerponHearthflameGF,
RagingBoltED,
FlutterManeGF,
ChienPaoDI

extends Pokemon {}

// --------- POKEMON SET: POPULATE WITH YOUR POKEMON ---------

fun metaSet: set Pokemon {
    // 2024 Worlds - Meta
    MiraidonED + OgerponTealG + FarigirafNP + CalyrexPI + UrshifuRapidStrikeWF + WhimsicottGF +
    // 2025 EUIC - Meta
    UrshifuWF + IncineroarFD + AmoongussGP + RillaboomG + OgerponHearthflameGF + RagingBoltED + FlutterManeGF + ChienPaoDI
}

// ---------- POKEMON TYPES: SET UP DECK TYPES HERE ----------
// add types to your defined pokemon so we know what types they have
// format: PokemonName.types = TypeName1 + TypeName2IfApplicable

pred setupMetaPokemon {
    // Defined in order of usage % on teams

    // Urshifu Rapid Strike (Water/Fighting) - used by 57.23% of players (293/512)
    UrshifuRapidStrikeWF.types = Water + Fighting

    // Incineroar (Fire/Dark) - used by 33.01% of players (169/512)
    IncineroarFD.types = Fire + Dark

    // Amoonguss (Grass/Poison) - used by 30.47% of players (156/512)
    AmoongussGP.types = Grass + Poison

    // Rillaboom (Grass) - used by 26.95% of players (138/512)
    RillaboomG.types = Grass

    // Ogerpon Hearthflame Mask (Grass/Fire) - used by 26.76% of players (137/512)
    OgerponHearthflameGF.types = Grass + Fire

    // Raging Bolt (Electric/Dragon) - used by 26.17% of players (134/512)
    RagingBoltED.types = Electric + Dragon

    // Flutter Mane (Ghost/Fairy) - used by 21.88% of players (112/512)
    FlutterManeGF.types = Ghost + Fairy

    // Chien Pao (Dark/Ice) - used by 21.68% of players (111/512)
    ChienPaoDI.types = Dark + Ice

    // UrshifuRapidStrike (Water/Fighting) - most common, appeared in 7/8 teams
    UrshifuWF.types = Water + Fighting

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

pred Battle2vMeta [n : Int] {
    typeProperties
    numTypes
    setupMetaPokemon
    teamMetaBreaker[MetaBreaker, MetaBreaker2, metaSet, n]
    setAttackingStatus
}

// ----------------------- RUN YOUR DECK ------------------------- 
// (just supply the # of pokemon the solver must beat in the meta)

run { Battle2vMeta[14] } for 6 Int