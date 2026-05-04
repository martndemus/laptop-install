#!/bin/bash
# Clone dotfiles repo and link everything into ~/.config/
set -euo pipefail
# shellcheck source=../lib/colors.sh
source "$(cd "$(dirname "$0")" && pwd)/../lib/colors.sh"

dotfiles="$DOTFILES_DIR"

if [[ ! -d "$dotfiles/.git" ]]; then
  print_step "Cloning dotfiles..."
  git clone "$DOTFILES_REPO" "$dotfiles"
else
  print_step "Pulling latest dotfiles..."
  git -C "$dotfiles" pull --ff-only
fi

print_step "Linking dotfiles..."
git -C "$dotfiles" ls-files | while read -r f; do
  dest="$HOME/.config/$f"
  mkdir -p "$HOME/.config/$(dirname "$f")"
  if [[ -e "$dest" || -L "$dest" ]] && [[ "$(readlink "$dest")" != "$dotfiles/$f" ]]; then
    mkdir -p "$HOME/.config/.backup/$(dirname "$f")"
    mv "$dest" "$HOME/.config/.backup/$f"
  fi
  ln -sf "$dotfiles/$f" "$dest"
done

print_step "Ensuring ~/.zshenv..."
cat > "$HOME/.zshenv" <<'EOF'
export ZDOTDIR="$HOME/.config/zsh"
[ -f "$ZDOTDIR/.zshenv" ] && . "$ZDOTDIR/.zshenv"
EOF
