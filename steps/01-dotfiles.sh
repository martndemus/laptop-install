#!/bin/bash
# Clone dotfiles repo and link everything into ~/.config/
set -euo pipefail

dotfiles="$HOME/Projects/dotfiles"

if [[ ! -d "$dotfiles/.git" ]]; then
  echo "Cloning dotfiles..."
  git clone "https://github.com/martndemus/dotfiles.git" "$dotfiles"
  git -C "$dotfiles" remote set-url origin "git@github.com:martndemus/dotfiles.git"
else
  echo "Dotfiles repo already cloned."
fi

echo "Linking dotfiles..."
git -C "$dotfiles" ls-files | while read -r f; do
  mkdir -p "$HOME/.config/$(dirname "$f")"
  ln -sf "$dotfiles/$f" "$HOME/.config/$f"
done

echo "Ensuring ~/.zshenv..."
cat > "$HOME/.zshenv" <<'EOF'
export ZDOTDIR="$HOME/.config/zsh"
[ -f "$ZDOTDIR/.zshenv" ] && . "$ZDOTDIR/.zshenv"
EOF
