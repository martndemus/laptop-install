#!/bin/bash
# Clone dotfiles repo and link everything into ~/.config/
set -euo pipefail

dotfiles="$HOME/Projects/dotfiles"

if [[ ! -d "$dotfiles/.git" ]]; then
  echo "Cloning dotfiles..."
  git clone "https://github.com/martndemus/dotfiles.git" "$dotfiles"
else
  echo "Dotfiles repo already cloned."
fi

echo "Linking dotfiles..."
git -C "$dotfiles" ls-files | while read -r f; do
  dest="$HOME/.config/$f"
  mkdir -p "$HOME/.config/$(dirname "$f")"
  if [[ -e "$dest" || -L "$dest" ]] && [[ "$(readlink "$dest")" != "$dotfiles/$f" ]]; then
    mkdir -p "$HOME/.config/.backup/$(dirname "$f")"
    mv "$dest" "$HOME/.config/.backup/$f"
  fi
  ln -sf "$dotfiles/$f" "$dest"
done

echo "Ensuring ~/.zshenv..."
cat > "$HOME/.zshenv" <<'EOF'
export ZDOTDIR="$HOME/.config/zsh"
[ -f "$ZDOTDIR/.zshenv" ] && . "$ZDOTDIR/.zshenv"
EOF
