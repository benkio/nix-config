# Modernization Evaluation

This document captures the outcome of evaluating the advanced modernization
items from the improvement plan.

## flake-parts + auto-import

- **Recommendation:** adopt later, not in this change set.
- **Why not now:** this repository just removed nested flakes and consolidated
  the root graph. Introducing `flake-parts` in the same step would increase
  migration risk and make troubleshooting harder.
- **When to adopt:** after CI parity has been stable for a few update cycles.

### Proposed migration path

1. Introduce `flake-parts` in `flake.nix` without changing output names.
2. Move host/home outputs into separate modules under `flake/modules/`.
3. Add optional auto-import for module files once the shape is stable.

## Formal profile model

- **Implemented now:** `systemCommon/profile.nix` provides
  `benkio.profile = "personal" | "work" | "ci"` plus feature toggles.
- **Current behavior:**
  - `personal`: secure defaults, work integrations off.
  - `work`: enables work integrations.
  - `ci`: disables unnecessary local services/features.

## Next candidates

- Add host-level explicit profile assignment in each host module.
- Move remaining profile booleans to one place per host.
- Add CI assertions to ensure intended profile defaults remain unchanged.
