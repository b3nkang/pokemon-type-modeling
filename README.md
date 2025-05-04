# Pokémon Type Advantage Team Builder

## Overview

This Forge model simulates the type-effectiveness system from Pokémon games to answer an interesting question: given information about an opponent's team composition, can we create an attacking team where at least one member can defeat each defending Pokémon through super-effective type matchups?

The model focuses purely on the "rock-paper-scissors" nature of Pokémon type advantages, removing all numerical stats and embracing a simplified One-Hit Knockout (OHKO) system based solely on type effectiveness.

A fundamental principle of Pokémon is the idea that trainers should be able to build teams with their favorite Pokémon while still having viable strategies against any opponent. This tension between using preferred Pokémon and maintaining competitive viability is at the heart of the gameplay. This model explores whether it's always possible to construct a counter-team with complete type coverage, or if there exist defensive team compositions that cannot be fully countered through type advantages alone.

## Concept

In Pokémon, certain types are super-effective against others (dealing 2x damage), not very effective (0.5x damage), or have no effect (0x damage). This creates a complex web of advantages and disadvantages, especially when Pokémon can have dual types.

This model explores whether, given information about a defending team, we can always construct an attacking team where:
- Each member of the defending team can be defeated by at least one attacker through type advantage
- The model considers all 18 Pokémon types and their complex interaction matrix

## Dual-Type Effectiveness Interactions

When a Pokémon has two types, the offensive effectiveness against it follows multiplicative rules, creating several important scenarios:

1. **Neutralization**: When one type is super-effective (2x) against a defending type, but the defender's second type is not very effective (0.5x) against it, these effects multiply to create normal effectiveness (2x × 0.5x = 1x)
   - Example: A Water/Ice Pokémon would take normal damage from Grass attacks (super-effective against Water, but not very effective against Ice)

2. **Compounded Weakness**: When both types share a weakness, the Pokémon becomes doubly weak (2x × 2x = 4x)
   - Example: A Bug/Grass type would take 4x damage from Fire attacks

3. **Compounded Resistance**: When both types resist the same attack type, the Pokémon becomes doubly resistant (0.5x × 0.5x = 0.25x)
   - Example: A Water/Dragon type would take only 0.25x damage from Water attacks

4. **Immunity Override**: An immunity (0x) from one type will always override any effectiveness from the other type (2x × 0x = 0x)
   - Example: A Ground/Ghost type is immune to Normal attacks despite not being weak to any particular type

These interaction rules create significant strategic depth in team building, as carefully chosen dual-types can neutralize what would otherwise be clear type disadvantages.

Note: The current model simplifies this by considering an attack successful if it's super-effective against at least one of the defender's types, without accounting for potential neutralization from the second type.

## Key Components

### Type System
- Implements all 18 Pokémon types: Normal, Fire, Water, Grass, Electric, Ice, Fighting, Poison, Ground, Flying, Psychic, Bug, Rock, Ghost, Dragon, Dark, Steel, and Fairy
- Each type has defined relationships with other types (super-effective, not very effective, no effect)
- These relationships form the core logic of the battle system

### Pokémon & Team Structure
- Pokémon can have one or two types (enforced by the `numTypes` predicate)
- Teams consist of multiple Pokémon (in the example, team size is set to 2)
- The `members` relation connects teams to their Pokémon

### Battle Logic
- `canOHKO` predicate: Determines if an attacker can One-Hit KO a defender based on type advantage
- `canFullyOHKO` predicate: Checks if an attacking team can collectively OHKO all members of a defending team

## Interesting Problem

The model explores an interesting question in Pokémon team building: given any possible defending team, can we always construct an attacking team that has at least one super-effective matchup against each defending Pokémon?

Due to the complex web of type interactions and dual-typing possibilities, this isn't trivial to prove mathematically. The Forge model helps explore this space by:
1. Finding examples where such an attacking team exists
2. Potentially identifying situations where it's impossible to build a team with complete type coverage


## Future Extensions

Possible extensions to this model could include:
- Expanding to larger team sizes (i.e. 6, which is the standard in the games)
- Adding move types separate from Pokémon types
- Incorporating the full dual-type effectiveness calculations
- Exploring minimal team composition that can counter any possible defending team
