#!/bin/bash
# Install a `laptop-update` command into ~/.local/bin/ that re-runs install.sh from anywhere
set -euo pipefail

here="$(cd "$(dirname "$0")" && pwd)"
repo="$(dirname "$here")"
# shellcheck source=../lib/colors.sh
source "$here/../lib/colors.sh"

bin_dir="$HOME/.local/bin"
mkdir -p "$bin_dir"

cat > "$bin_dir/laptop-update" <<EOF
#!/bin/bash
exec "$repo/install.sh" "\$@"
EOF
chmod +x "$bin_dir/laptop-update"

print_step "Installed laptop-update to $bin_dir/laptop-update"

case ":$PATH:" in
  *":$bin_dir:"*) ;;
  *) print_warn "$bin_dir is not on your PATH." ;;
esac
