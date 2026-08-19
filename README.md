# LearnGodotEngine

Endless runner built to learn Godot 4 end to end: a car drives forward on its
own down a three-lane road, and the player dodges by switching lanes.

Learning project, not aimed at release. Full design intent: [`docs/gdd.md`](docs/gdd.md).

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

## Roadmap

- [x] Project skeleton and folder structure
- [x] Car scene with physics-driven forward movement
- [x] Lane-switch input, left and right
- [x] Third-person follow camera
- [x] Test track with three fixed lanes
- [ ] Endless scrolling track
- [ ] Obstacle (box) scene with collision
- [ ] Obstacle spawner — timer-based, random lane, rising frequency
- [ ] Collision wired to game over through a `car_hit` signal
- [ ] `GameManager` autoload for score and state
- [ ] Distance-based scoring
- [ ] Difficulty scaling through `@export` tuning values
- [ ] Score HUD and game over screen with restart
- [ ] Restart flow with a persisted local high score
