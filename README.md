<div align="center">
  <h1>Dotfiles</h1>
  <p>My personal dotfiles for macOS.</p>
</div>

<a href="https://github.com/gingama4/dotfiles/actions/workflows/macos-setup.yml"><img src="https://github.com/gingama4/dotfiles/actions/workflows/macos-setup.yml/badge.svg" alt="macOS setup"></a>

## Setup

Run the setup script on macOS:

```sh
curl -fsSL https://raw.githubusercontent.com/gingama4/dotfiles/master/setup.sh | bash
```

The script performs the following steps:

1. Installs Nix using the [Lix installer](https://lix.systems/install/) if needed.
2. Clones this repository to `~/dotfiles`.
3. Applies the nix-darwin configuration.
4. Applies the Home Manager configuration.

The nix-darwin step may prompt for your administrator password.

To rerun only selected setup steps, run the cloned script interactively and
choose from its menu:

```sh
~/dotfiles/setup.sh
```

The flake manages the system and user environment separately:

- `darwinConfigurations.hades`: macOS settings, Homebrew, and Nix itself.
- `homeConfigurations.normal`: standalone Home Manager for `gingama4`.

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
