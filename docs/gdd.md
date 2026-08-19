# Endless Runner – Car Dodge (Learning Project)

**Goal:** learn core Godot systems (2D physics, input, scene instancing, signals, UI, autoload) by building a small, complete game end to end. Not intended for commercial release — a hands-on exercise following [[Folder Structure Conventions]] and [[GDScript Style Guide]].

## Concept

Third-person 3D endless runner. A car auto-moves forward on a scrolling road; the player switches lanes to dodge incoming boxes. Speed increases over time. Game ends on collision. Score = distance survived.

## Core loop

1. Car moves forward automatically.
2. Obstacles (boxes) spawn ahead in one of N lanes.
3. Player switches lanes (left/right) to avoid them.
4. Score increases with distance/time.
5. On collision → Game Over screen → restart.

## Controls

- Left / Right (arrow keys or A/D): switch lane
- Space (or button) on Game Over screen: restart

## Mechanics

- **Lanes:** fixed number (e.g. 3), car snaps between them.
- **Obstacle spawning:** timer-based, random lane, increasing frequency over time.
- **Difficulty scaling:** speed increases with score/time (simple linear or step curve).
- **Scoring:** distance-based, persisted as a local high score.
- **Collision:** `Area3D`/`CharacterBody3D` collision triggers Game Over.

## Scope (MVP)

- 1 playable scene (endless track)
- 1 car (player), 1 obstacle type (box)
- Simple UI: score HUD, Game Over screen with restart
- Primitive shapes/placeholder sprites, no final art
- No audio (stretch goal only)

## Out of scope for this pass

- Multiple obstacle types / power-ups
- Level design / checkpoints
- Menus beyond Game Over
- Mobile/controller input
- Save system beyond local high score

## Godot systems to practice

- Scene composition & instancing (`PackedScene`, `instantiate()`)
- `CharacterBody3D` / `Area3D` + collision signals
- `Camera3D` follow behavior (third-person, fixed offset)
- `Timer` nodes for spawning
- Autoload singleton (`GameManager`) for score/state
- Signals for decoupled communication (`car_hit`, `score_changed`)
- Basic UI over a 3D viewport (`CanvasLayer`, `Label`, `Button`)
- `@export` variables for tuning (speed, spawn rate)
