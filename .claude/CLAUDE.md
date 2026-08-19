# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

- Godot 4.7 learning project: endless runner, car auto-drives down a 3-lane road, player switches lanes to dodge.
- Not aimed at release. Design intent: `docs/gdd.md`. Current scope/roadmap: `README.md`.

## Running

- Godot 4.7, GL Compatibility renderer, Jolt Physics.
- Open in editor, `F5`. Main scene: `scenes/levels/lvl_game.tscn`.
- Controls: `A`/`←`, `D`/`→` (actions `move_left`/`move_right`).
- No CLI build/lint/test tooling, no automated tests — editor-only workflow.

## Folder layout

```
assets/     models, textures, materials, audio, fonts
scenes/     characters, levels, ui
scripts/    gameplay code (autoload, components, systems)
resources/  custom .tres data
```

## Commits

- Format: `<type>: <description>`.
- Types (from `git log` / `docs/version_control.md`): `feat`, `fix`, `refactor`, `scene`, `asset`, `maintenance`, `docs`, `build`.
