<div align="center">
  <h1>Dotfiles</h1>
  <p>My personal dotfiles for setting up a new machine.</p>
</div>

## Setup

Run the following command (with apply):
```bash
bash -c "$(curl -fsLS get.chezmoi.io)" -- init gingama4 --apply
```


or run the setup.sh (only init):
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/gingama4/dotfiles/refs/heads/master/setup.sh)"
```

## Nix

Tool installation is managed by Nix. chezmoi still distributes configuration files.

macOS uses nix-darwin, Home Manager, and Homebrew casks managed from Nix:
```bash
darwin-rebuild switch --flake ~/.local/share/chezmoi#hades
```

Ubuntu on WSL uses standalone Home Manager:
```bash
home-manager switch --flake ~/.local/share/chezmoi#wsl
```
