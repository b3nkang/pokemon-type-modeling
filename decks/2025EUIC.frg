#lang forge

open "../types.frg"
open "../1v1.frg"

// ******** DECK OVERVIEW ******** //
//
// This is a deck based on the VGC meta of the 2025 European International Championships,
// the largest VGC Pokemon tournament in HISTORY by registrations with 512. This meta-deck
// is composed all Pokemon that saw >20% usage on all players' teams, totalling 8 Pokemon. 
//
// Source: https://www.nimbasacitypost.com/2025/02/europe-international-2025.html 
//         (usage stats are at the bottom of the article, based on points)


// --------- BELOW, NEW DECK: DEFINE POKEMON SIGS IN DECK -----------

one sig 
UrshifuRapidStrikeWF,
IncineroarFD,
AmoongussGP,
RillaboomG,
OgerponHearthflameGF,
RagingBoltED,
FlutterManeGF,
ChienPaoDI
extends Pokemon {}


// --------- POKEMON SET: POPULATE WITH YOUR POKEMON ---------
// add your pokemon into this func which creates a set of your pokemon.
// this func is used throughout the 1v1.frg logic so you must fill it.

fun metaSet: set Pokemon {
    UrshifuRapidStrikeWF + IncineroarFD + AmoongussGP + RillaboomG + OgerponHearthflameGF + RagingBoltED + FlutterManeGF + ChienPaoDI
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
// Replace "n" below with the # of pokemon the solver must beat in your deck.
//       (or just comment it out if you need to run the deck in 1v1maxFinder.frg)
// Constraints: n !> |deck|, solver cannot beat more pokemon than in your deck itself

run { Battle1v1Meta[6] } for 6 Int

// RUN RESULTS: 
// - the maximum number of KOs in this meta is 6 for an optimal matchup
// - 6 types can achieve 6 KOs:
//      - Flying/Rock:
//              Defeats...
//                  Amoonguss (Grass Weakness), Ogerpon Hearthflame Mask (Grass Weakness),
//                  Rillabom (Grass Weakness),  Incineroar (Dark Weakness), Chien-Pao (Ice Weakness)
//              Cannot OHKO...
//                  Flutter Mane (Ghost/Fairy), Raging Bolt (Electric/Dragon)
//              Example Pokemon inclue...
//                  Aerodactyl, Archeops
//      - Flying/Fairy
//              Defeats...
//                  TODO:
//              Cannot OHKO...
//                  TODO:
//              Example Pokemon inclue...
//                  TODO:
//      - Flying/Steel
//              Defeats...
//                  TODO:
//              Cannot OHKO...
//                  TODO:
//              Example Pokemon inclue...
//                  TODO:
//      - Flying/Fighting
//              Defeats...
//                  TODO:
//              Cannot OHKO...
//                  TODO:
//              Example Pokemon inclue...
//                  TODO:
//      - Flying/Ground
//              Defeats...
//                  TODO:
//              Cannot OHKO...
//                  TODO:
//              Example Pokemon inclue...
//                  TODO:
//      - Ice/Rock
//              Defeats...
//                  TODO:
//              Cannot OHKO...
//                  TODO:
//              Example Pokemon inclue...
//                  TODO:
