# LearnGodotEngine

A car drives forward on its own down a three-lane road and the player dodges
by switching lanes. Built as a hands-on evaluation of Godot 4 and GDScript —
not a game meant to ship, but a way to learn the engine's architecture, see
how it compares to Unity, and judge what (if anything) is worth bringing into
day-to-day workflow.

**Status: concluded.** The project stops at what's listed below — no scoring,
game over, UI, or further gameplay is planned. Background and evaluation
notes: [`docs/gdd.md`](docs/gdd.md).

## Requirements

Godot **4.7** — GL Compatibility renderer, Jolt Physics.

## Running

Open the project in Godot and press `F5`. Main scene: `scenes/levels/lvl_game.tscn`.

## Controls

| Action | Keys |
|---|---|
| One lane left | `A` / `←` |
| One lane right | `D` / `→` |

The car accelerates by itself and never turns — a lane change is a sideways
slide between fixed positions on the road (x = -2.5, 0, +2.5).

## Layout

```
assets/     models, textures, materials, audio, fonts
scenes/     cars, levels, road, obstacles, ui
scripts/    car, road, camera, obstacles
resources/  custom .tres data
docs/       design doc, process notes
```

Organised by resource type.

## What's implemented

- Project skeleton and folder structure
- Car scene with physics-driven forward movement
- Lane-switch input, left and right
- Third-person follow camera
- Endless scrolling track (segment spawner)
- Obstacle (box) scene with collision
- Obstacle spawner — timer-based, random lane

Scoring, game over, UI, and further gameplay were part of the original design
but were deliberately dropped once the evaluation goal was met — see
[`docs/gdd.md`](docs/gdd.md) for the full original plan and what was learned.
