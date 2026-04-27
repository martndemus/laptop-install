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
| `brew` | Install Homebrew and the packages listed in `brew-packages.txt` |
| `macos-appstore-apps` | Install Mac App Store apps via `mas` |
| `macos-settings` | Apply macOS `defaults` (Dock, Finder, trackpad, keyboard, Safari, …) |

Steps are auto-discovered from the `steps/` directory and ordered by their numeric prefix. To add a new step, drop in a new file like `steps/05-dotfiles.sh` — no edit to `install.sh` required.

## Customizing packages

Edit `brew-packages.txt`. One package per line; `#` starts a comment. Homebrew auto-detects formulae vs. casks, so no `--cask` flag is needed.

## Notes

- The `macos-settings` step's Safari section requires Full Disk Access for your terminal (System Settings → Privacy & Security → Full Disk Access). It will warn and skip those defaults if access isn't granted.
- The `clt` step may exit early and ask you to complete a GUI prompt the first time Command Line Tools are installed; re-run after.
