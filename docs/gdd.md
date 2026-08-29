# Endless Runner – Car Dodge (Learning Project, concluded)

**Goal:** use a small endless-runner prototype as a hands-on way to learn Godot's architecture and GDScript — scene composition, physics, input, signals — and evaluate the engine against Unity as a possible addition to day-to-day workflow. Not a commercial game, and not meant to be finished as a complete game; the exercise stops once it had covered enough ground to judge the engine and pull out useful takeaways.

**Outcome:** the project was closed at the scope in [README's "What's implemented"](../README.md#whats-implemented) — car movement, lane switching, an endless scrolling track, obstacles, and a follow camera. The remaining systems described below (scoring, game over, UI, difficulty scaling) were part of the original design but were never built; they're kept here only as a record of the original plan, not as pending work.

## Original design (not fully built)

The rest of this document is the design as planned before work started. It
describes the complete game that was scoped out, not what exists in the repo
today — see **Outcome** above for the actual final feature set.

### Concept

Third-person 3D endless runner. A car auto-moves forward on a scrolling road; the player switches lanes to dodge incoming boxes. Speed increases over time. Game ends on collision. Score = distance survived.

### Core loop

1. Car moves forward automatically.
2. Obstacles (boxes) spawn ahead in one of N lanes.
3. Player switches lanes (left/right) to avoid them.
4. Score increases with distance/time.
5. On collision → Game Over screen → restart.

### Controls

- Left / Right (arrow keys or A/D): switch lane
- Space (or button) on Game Over screen: restart

### Mechanics

- **Lanes:** fixed number (e.g. 3), car snaps between them.
- **Obstacle spawning:** timer-based, random lane, increasing frequency over time.
- **Difficulty scaling:** speed increases with score/time (simple linear or step curve).
- **Scoring:** distance-based, persisted as a local high score.
- **Collision:** `Area3D`/`CharacterBody3D` collision triggers Game Over.

### Scope (MVP)

- 1 playable scene (endless track)
- 1 car (player), 1 obstacle type (box)
- Simple UI: score HUD, Game Over screen with restart
- Primitive shapes/placeholder sprites, no final art
- No audio (stretch goal only)

### Out of scope for this pass

- Multiple obstacle types / power-ups
- Level design / checkpoints
- Menus beyond Game Over
- Mobile/controller input
- Save system beyond local high score

### Godot systems targeted

- Scene composition & instancing (`PackedScene`, `instantiate()`)
- `CharacterBody3D` / `Area3D` + collision signals
- `Camera3D` follow behavior (third-person, fixed offset)
- `Timer` nodes for spawning
- Autoload singleton (`GameManager`) for score/state
- Signals for decoupled communication (`car_hit`, `score_changed`)
- Basic UI over a 3D viewport (`CanvasLayer`, `Label`, `Button`)
- `@export` variables for tuning (speed, spawn rate)

## Godot systems actually practiced

What the finished portion of the project ended up exercising:

- Scene composition & instancing (`PackedScene`, `instantiate()`) — road segments and obstacles
- `CharacterBody3D` + `move_and_slide()` for the car
- `Camera3D` follow behavior, decoupled from the car via a target `NodePath`
- `Timer`-driven spawning for both the road and obstacles
- `@export` variables for tuning (speed, lane distance, spawn interval)

Not reached: autoload singletons, signal-based decoupling (`car_hit` /
`score_changed`), and any UI (`CanvasLayer`, `Label`, `Button`) — the project
concluded before those came up.
