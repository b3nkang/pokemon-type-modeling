#lang forge

open "../types.frg"
open "../1vM.frg"

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
// this func is used throughout the 1vM.frg logic so you must fill it.

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
// - The maximum number of KOs in this meta is 6 out of 8 Pokémon
// - 6 different type combinations can achieve exactly 6 KOs:
//      - Flying/Rock:
//              Defeats (6):
//                  Urshifu (Water/Fighting - weak to Flying)
//                  Amoonguss (Grass/Poison - weak to Flying)
//                  Rillaboom (Grass - weak to Flying)
//                  Incineroar (Fire/Dark - weak to Rock)
//                  Ogerpon Hearthflame (Grass/Fire - weak to Flying and Rock)
//                  Chien-Pao (Dark/Ice - weak to Rock)
//              Cannot OHKO (2):
//                  Flutter Mane (Ghost/Fairy - no weakness to Flying or Rock)
//                  Raging Bolt (Electric/Dragon - Electric resists Flying)
//              Example Pokémon:
//                  Aerodactyl, Archeops, Minior
//
//      - Flying/Fairy:
//              Defeats (6):
//                  Urshifu (Water/Fighting - weak to Flying and Fairy)
//                  Amoonguss (Grass/Poison - Grass weak to Flying, Poison weak to Fairy)
//                  Rillaboom (Grass - weak to Flying)
//                  Incineroar (Fire/Dark - Dark weak to Fairy)
//                  Ogerpon Hearthflame (Grass/Fire - Grass weak to Flying)
//                  Raging Bolt (Electric/Dragon - Dragon weak to Fairy)
//              Cannot OHKO (2):
//                  Flutter Mane (Ghost/Fairy - Fairy resists Fairy)
//                  Chien-Pao (Dark/Ice - Dark weak to Fairy but Ice resists Fairy)
//              Example Pokémon:
//                  Togekiss, Mega Altaria
//
//      - Flying/Steel:
//              Defeats (6):
//                  Urshifu (Water/Fighting - weak to Flying)
//                  Amoonguss (Grass/Poison - Grass weak to Flying, Poison weak to Steel)
//                  Rillaboom (Grass - weak to Flying and Steel)
//                  Ogerpon Hearthflame (Grass/Fire - Grass weak to Flying)
//                  Flutter Mane (Ghost/Fairy - Fairy weak to Steel)
//                  Chien-Pao (Dark/Ice - Ice weak to Steel)
//              Cannot OHKO (2):
//                  Incineroar (Fire/Dark - Fire resists Steel)
//                  Raging Bolt (Electric/Dragon - Electric resists Flying)
//              Example Pokémon:
//                  Skarmory, Corviknight, Celesteela
//
//      - Flying/Fighting:
//              Defeats (6):
//                  Urshifu (Water/Fighting - weak to Flying)
//                  Amoonguss (Grass/Poison - Grass weak to Flying)
//                  Rillaboom (Grass - weak to Flying)
//                  Incineroar (Fire/Dark - Dark weak to Fighting)
//                  Ogerpon Hearthflame (Grass/Fire - Grass weak to Flying)
//                  Chien-Pao (Dark/Ice - Dark and Ice both weak to Fighting)
//              Cannot OHKO (2):
//                  Flutter Mane (Ghost/Fairy - Ghost immune to Fighting)
//                  Raging Bolt (Electric/Dragon - Electric resists Flying)
//              Example Pokémon:
//                  Hawlucha
//
//      - Flying/Ground:
//              Defeats (6):
//                  Urshifu (Water/Fighting - Fighting weak to Flying)
//                  Amoonguss (Grass/Poison - Grass weak to Flying, Poison weak to Ground)
//                  Rillaboom (Grass - weak to Flying)
//                  Incineroar (Fire/Dark - Fire weak to Ground)
//                  Ogerpon Hearthflame (Grass/Fire - Grass weak to Flying, Fire weak to Ground)
//                  Chien-Pao (Dark/Ice - Ice weak to Ground)
//              Cannot OHKO (2):
//                  Flutter Mane (Ghost/Fairy - Ghost immune to Ground)
//                  Raging Bolt (Electric/Dragon - Electric resists Flying)
//              Example Pokémon:
//                  Gliscor, Landorus, Gligar, Flygon, Garchomp
//
//      - Ice/Rock:
//              Defeats (6):
//                  Urshifu (Water/Fighting - Fighting weak to Rock)
//                  Amoonguss (Grass/Poison - Grass weak to Ice)
//                  Rillaboom (Grass - weak to Ice)
//                  Incineroar (Fire/Dark - Fire weak to Rock)
//                  Ogerpon Hearthflame (Grass/Fire - Grass weak to Ice, Fire weak to Rock)
//                  Raging Bolt (Electric/Dragon - Dragon weak to Ice)
//              Cannot OHKO (2):
//                  Flutter Mane (Ghost/Fairy - no weakness to Ice or Rock)
//                  Chien-Pao (Dark/Ice - Ice resists Ice)
//              Example Pokémon:
//                  Aurorus, Amaura
