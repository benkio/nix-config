# Sway + Waybar Evaluation

This repository currently uses Sway's built-in bar with `i3status-rust`.
For a minimal-change UX refresh, this remains the recommended default.

## Decision

- Keep the current Sway bar + `i3status-rust` now.
- Defer `waybar` migration to a later phase.

## Why defer

- Existing setup is stable and already integrated with your fonts and workflow.
- `waybar` adds extra CSS/module configuration surface and migration cost.
- Current UX improvements (lock flow, mako, launcher, clipboard/screenshots)
  deliver most value without changing bar architecture.

## If you migrate later

1. Enable `programs.waybar` in Home Manager.
2. Recreate current modules: workspace, net, battery, sound, time.
3. Keep Sway keybindings unchanged to avoid workflow disruption.
4. Remove `bars` stanza in `NixOs/home/sway.nix` only after parity check.
