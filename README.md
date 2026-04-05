# Prolog Chess Engine

## Overview

This project implements a simplified chess engine in Prolog. It supports automated gameplay between two players using rule-based logic and alpha-beta pruning for move selection.

The system:
- Represents a chess board using structured Prolog terms
- Generates legal moves based on standard chess rules (with some constraints)
- Evaluates board states using a heuristic function
- Uses alpha-beta pruning to select moves efficiently
- Supports automated play between two AI players

Core implementation is contained in :contentReference[oaicite:0]{index=0}.

---

## Features

- Full chess board representation and move generation
- Two-player system:
  - `playerA` (white)
  - `playerB` (black)
- Alpha-beta pruning for decision making
- Heuristic evaluation based on piece values
- Board visualization in terminal
- Automated gameplay loop

---

## Game Rules

The engine follows standard chess rules with the following simplifications:

- No en passant
- Pawns promote to queens only
- No draw by repetition or capture
- Castling rules are relaxed (can pass through check)

---

## How to Run

### Using SWI-Prolog

```bash
swipl chess.pl