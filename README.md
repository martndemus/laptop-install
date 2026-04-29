# laptop-install

Bootstraps a fresh macOS laptop: Command Line Tools, Homebrew + packages, Mac App Store apps, and macOS system defaults.

## Usage

```sh
./install.sh                              # run all steps
./install.sh --steps=brew,macos-settings  # run only these
./install.sh --skip=clt                   # run all except these
./install.sh --help
```

`--steps` and `--skip` can be combined. Steps always run in their canonical order regardless of the order passed.

## Steps

Each step lives in `steps/NN-name.sh` and can also be run standalone:

| Step | Description |
| --- | --- |
| `clt` | Install / update Xcode Command Line Tools |
| `dotfiles` | Clone `martndemus/dotfiles` to `~/Projects/dotfiles` and symlink each tracked file into `~/.config/` (existing files are moved to `~/.config/.backup/`); also writes `~/.zshenv` to point `ZDOTDIR` at `~/.config/zsh` |
| `brew` | Install Homebrew and the packages listed in `brew/formulae` and `brew/casks` |
| `macos-appstore-apps` | Install Mac App Store apps via `mas` |
| `macos-settings` | Apply macOS `defaults` (Dock, Finder, trackpad, keyboard, Safari, …) |
| `install-shortcut` | Install a `laptop-update` command in `~/.local/bin/` that re-runs `install.sh` from anywhere |

Steps are auto-discovered from the `steps/` directory and ordered by their numeric prefix. To add a new step, drop in a new file like `steps/05-dotfiles.sh` — no edit to `install.sh` required.

## Customizing packages

Edit `brew/formulae` (CLI tools) or `brew/casks` (GUI apps). One package per line.

## Notes

- The `macos-settings` step's Safari section requires Full Disk Access for your terminal (System Settings → Privacy & Security → Full Disk Access). It will warn and skip those defaults if access isn't granted.
- The `clt` step may exit early and ask you to complete a GUI prompt the first time Command Line Tools are installed; re-run after.
