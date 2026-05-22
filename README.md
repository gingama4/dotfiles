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

Tool installation is managed by Nix. chezmoi still distributes configuration
files and generates a local flake at `~/.config/dotfiles-nix/flake.nix`.

chezmoi prompts for the Nix profile name and OS user name. For a work WSL
environment, use a profile such as `wsl-work`.

Activate macOS with nix-darwin:
```bash
darwin-rebuild switch --flake ~/.config/dotfiles-nix#hades
```

Activate Linux or WSL with standalone Home Manager:
```bash
home-manager switch --flake ~/.config/dotfiles-nix#linux
# or
home-manager switch --flake ~/.config/dotfiles-nix#wsl-work
```

The public flake still exposes reusable builders for private flakes:
```nix
{
  inputs.dotfiles.url = "github:gingama4/dotfiles";

  outputs = { dotfiles, ... }: {
    darwinConfigurations.mac = dotfiles.lib.mkMacConfiguration {
      username = "your-private-mac-user";
    };

    homeConfigurations.linux = dotfiles.lib.mkLinuxHome {
      username = "your-private-linux-user";
    };

    homeConfigurations.wsl-work = dotfiles.lib.mkWslWorkHome {
      username = "your-private-work-user";
    };
  };
}
```

Test the WSL/Ubuntu path in Docker:
```bash
./scripts/test_wsl_docker.sh
```

Test the macOS path with Nix:
```bash
./scripts/test_macos.sh
```
