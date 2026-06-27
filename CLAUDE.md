# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Key Commands

**Format code:**
```bash
nix fmt
```

**Check a flake output evaluates:**
```bash
nix flake check
```

**Build a NixOS configuration:**
```bash
# For jugito (current laptop, flake-parts style)
nh os build .#jugito

# For juugas (older host, classic style)
nixos-rebuild build --flake .#juugas
```

**Apply to current system (jugito):**
```bash
nh os switch .
```

**Build a home-manager configuration:**
```bash
nix build .#homeConfigurations.lucab.activationPackage
```

## Repository Architecture

This is a NixOS + Home Manager configuration for two hosts managed as a Nix flake.

### Two Coexisting Styles

The repo is mid-migration from a classic NixOS module style to `flake-parts`:

- **`hosts/juugas/`** — Older, monolithic style. NixOS config in `configuration.nix`, home-manager config in `users/lucab/home-configuration.nix`. Home Manager modules consumed from `modules/home/`.
- **`flake-modules/hosts/jugito/`** — New style using `flake-parts`. The host is assembled from discrete `nixosModules` (`jugito-base`, `jugito-hardware`, `jugito-disko`, `niri`, `lucab`) defined across separate files. The home-manager config is composed from `flake.modules.homeManager.*` entries. Uses `nh` for building and GC.

### flake-parts Module System

`flake.nix` uses `flake-parts` and auto-imports everything under `flake-modules/` via `import-tree`. Each `.nix` file there contributes to the flake by returning a `flake-parts` module (returning attrs like `flake.*`, `perSystem.*`).

**`flake.modules.homeManager.<name>`** is a custom namespace (enabled by `hm-wrapper-modules` and `flake-parts.flakeModules.modules` in `wrapped-packages.nix`) for declaring reusable home-manager modules that can be referenced by name from `lucab.nix`.

**`perSystem.hmWrappers`** (from `hm-wrapper-modules`) auto-generates `homeConfigurations` entries from home-manager module definitions.

### Notable Inputs

| Input | Purpose |
|---|---|
| `niri` | Wayland compositor (sodiboo flake); used for `jugito` |
| `nixvim` | Neovim configured via Nix |
| `noctalia` | Custom shell/launcher (noctalia-dev); started at login and used for keybinds |
| `stylix` | System-wide theming |
| `disko` | Declarative disk partitioning for `jugito` |
| `wrapper-modules` / `hm-wrapper-modules` | Wrap packages and home-manager configs declaratively |
| `import-tree` | Auto-imports all `flake-modules/**/*.nix` |
| `treefmt-nix` | Formatting; configured in `formatter.nix` to use `nixfmt --strict` |

### jugito Disk Layout

`jugito` uses LUKS-on-btrfs with subvolumes: `/root`, `/home`, `/nix`, `/persist`, `/var/log`, `/var/lib`, and a swapfile under `/persist/swap`. `/persist`, `/var/log`, and `/var/lib` are flagged `neededForBoot`.

### Formatter

`nixfmt` in strict mode (via `treefmt-nix`). Run `nix fmt` to format all `.nix` files.
