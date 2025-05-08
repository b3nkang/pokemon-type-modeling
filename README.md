# Pokémon Type Advantage Modeling
CS 1710 – Logic for Systems

[Demo Video](https://drive.google.com/file/d/1_REff1rMY1jQhyx4F6gv2xh7heS-ao_y/view?usp=sharing)

## Project Overview

This project uses formal verification through the Forge modeling language to analyze Pokémon type matchups and competitive team building strategies. We explore optimal counter-strategies across different competitive formats and eras by modeling the complex type effectiveness system from Pokémon games.

## Model Structure & Design Decisions

Our model is structured around three core components:

1. **Type System (`types.frg`)**: Models all 18 Pokémon types and their effectiveness relationships.
2. **1vM Analysis (`1vM.frg`)**: Finds a single Pokémon with optimal type coverage against a meta.
3. **2vM Analysis (`2vM.frg`)**: Finds a pair of Pokémon with optimal combined type coverage.

### Key Design Tradeoffs

The most significant tradeoff was simplifying the damage calculation system to focus solely on type advantages. In the actual games, damage is determined by numerous factors (stats, moves, abilities, items). We simplified this to a binary OHKO (One-Hit Knockout) model based only on type effectiveness, which allowed us to focus on finding optimal type combinations.


### Scope Assumptions & Limitations

Our model makes several simplifying assumptions:
- Pokémon can only have up to 2 types (authentic to the games)
- All moves are STAB (Same Type Attack Bonus) moves
- No items, abilities, or other modifiers affect type relationships
- No consideration of move selection (only type-based attacks)
- No difference in the amount of damage that attacks deal

The primary limitation is that our model doesn't account for cases where a player could use strategy to overcome their Pokémon's type weakness, for example with things like status conditions, abilities, etc. However, this was a necessary limitation to focus the scope of our project.

## Goal Evolution

Our original proposal focused simply on finding anomalies within the type system, such as types that perform unusually well or unusually poorly within the system as a whole. While we were able to achieve this, it was still far from the complexity and nuance in professional Pokémon, which led to us thinking about looking at different metas.

This shift allowed us to create a model that not only works with theoretical type matchups but actually provides actionable insights for competitive players by identifying optimal counter-picks for specific tournament formats and eras.

## Understanding Model Instances

An instance of our model represents a hypothetical Pokémon with a specific type combination that can counter a certain number of Pokémon in a given meta. For example, the model can show that a Flying/Rock type Pokémon can defeat 6 out of 8 Pokémon in the 2025 EUIC meta.

The model uses the concept of "OHKO" (One-Hit Knockout) based on type advantages. A Pokémon can OHKO another if at least one of its types is super-effective against one of the target's types, without being resisted or negated by the target's other type.

In 2vM analysis, an instance shows a pair of Pokémon that together can counter a maximum number of meta Pokémon, representing an optimal team core for countering a specific metagame.

We unfortunately did not have the time to develop a custom visualization, but the table view within Sterling is sufficient to see which types the solution chooses against the given meta.

## Key Findings

Our most interesting result came from the 2025 EUIC analysis, where we found that no single Pokémon type combination can counter more than 6 out of 8 meta Pokémon (75% coverage). However, we identified exactly six type combinations that achieve this maximum: Flying/Rock, Flying/Fairy, Flying/Steel, Flying/Fighting, Flying/Ground, and Ice/Rock.

The prevalence of Flying combinations in optimal counters reveals interesting structural features of the current meta, highlighting the effectiveness of Flying-type attacks against the Grass and Fighting types that dominate competitive play.


## Future Directions

Future work could focus on:
- Expanding to 6v6 team analysis (more realistic to the game)
- Adding move type modeling distinct from Pokémon typing
- Implementing full dual-type effectiveness calculations with proper neutralization
- Exploring historical meta shifts through formal analysis
- Identifying theoretical "perfect coverage" teams

---

**Collaborators**: Jonathan Becker, Ben Kang, Camilo Tamayo-Rousseau
