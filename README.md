# LearnGodotEngine

A car drives forward on its own down a three-lane road and the player dodges
by switching lanes. Built as a hands-on evaluation of Godot 4 and GDScript —
not a game meant to ship, but a way to learn the engine's architecture, see
how it compares to Unity, and judge what (if anything) is worth bringing into
day-to-day workflow.

**Status: concluded.** The project stops at what's listed in the Roadmap
below — no scoring, game over, UI, or further gameplay is planned. Background
and evaluation notes: [`docs/gdd.md`](docs/gdd.md).

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
scenes/     cars, levels, ui
scripts/    car, components (autoload, systems planned)
resources/  custom .tres data
docs/       design doc, process notes
```

Organised by resource type.

## Roadmap (final)

Everything below is what got built before the project was called done. Items
left unchecked were part of the original design but were deliberately dropped
once the evaluation goal was met — see [`docs/gdd.md`](docs/gdd.md).

- [x] Project skeleton and folder structure
- [x] Car scene with physics-driven forward movement
- [x] Lane-switch input, left and right
- [x] Third-person follow camera
- [x] Endless scrolling track (segment spawner)
- [x] Obstacle (box) scene with collision
- [x] Obstacle spawner — timer-based, random lane
- [ ] ~~Collision wired to game over through a `car_hit` signal~~ — dropped
- [ ] ~~`GameManager` autoload for score and state~~ — dropped
- [ ] ~~Distance-based scoring~~ — dropped
- [ ] ~~Difficulty scaling through `@export` tuning values~~ — dropped
- [ ] ~~Score HUD and game over screen with restart~~ — dropped
- [ ] ~~Restart flow with a persisted local high score~~ — dropped
