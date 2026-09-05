<div align="center">
  <h1>Dotfiles</h1>
  <p>My personal dotfiles for macOS.</p>
</div>

## Setup

Install Nix using the [Lix installer](https://lix.systems/install/), then clone
this repository to `~/dotfiles`.

The flake manages the system and user environment separately:

- `darwinConfigurations.hades`: macOS settings, Homebrew, and Nix itself.
- `homeConfigurations.normal`: standalone Home Manager for `gingama4`.

## System configuration

Bootstrap nix-darwin:

```sh
sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake ~/dotfiles#hades
```

Apply subsequent system changes:

```sh
sudo darwin-rebuild switch --flake ~/dotfiles#hades
```

## User configuration

Build and activate Home Manager for the first time, without sudo:

```sh
nix run home-manager/master -- switch --flake .#normal
```

Apply subsequent user configuration changes:

```sh
home-manager switch --flake ~/dotfiles#normal
```

## Updating

```sh
cd ~/dotfiles
nix flake update
sudo darwin-rebuild switch --flake .#hades
home-manager switch --flake .#normal
```

Commit `flake.lock` to preserve the selected dependency versions. Keep
`home.stateVersion` unchanged when updating inputs unless deliberately migrating
Home Manager compatibility behavior.
