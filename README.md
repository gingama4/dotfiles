# dotfiles

## Supported OS

- Darwin (ARM64)
- Ubuntu - CLI (x86_64)

### Hosts and OS (Device)

| Name        | Description          |
| ----------- | -------------------- |
| hades       | M4 Mac mini          |
| hythlodaeus | Work PC (Ubuntu CLI) |

## Install

Run the following:

### Hades

```bash
nix run nix-darwin -- switch --flake .
```

### Hythlodaeus

```bash
nix run nixpkgs#home-manager -- switch --flake .#hythlodaeus
```

## References

- [asa1984/dotfiles](https://github.com/asa1984/dotfiles)
- [mkt3/dotfiles](https://github.com/mkt3/dotfiles)
- [yutkat/dotfiles](https://github.com/yutkat/dotfiles)
