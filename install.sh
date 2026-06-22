#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "[*] Installing pipx..."
sudo apt install -y pipx
pipx ensurepath

echo "[*] Installing netexec..."
pipx install "$SCRIPT_DIR"

echo "[*] Setting up tab completion..."
COMPLETION_LINE_NXC='eval "$(register-python-argcomplete nxc)"'
COMPLETION_LINE_NXCDB='eval "$(register-python-argcomplete nxcdb)"'

add_to_rc() {
    local rc_file="$1"
    if [ -f "$rc_file" ]; then
        grep -qF "register-python-argcomplete nxc" "$rc_file" || echo "$COMPLETION_LINE_NXC" >> "$rc_file"
        grep -qF "register-python-argcomplete nxcdb" "$rc_file" || echo "$COMPLETION_LINE_NXCDB" >> "$rc_file"
        echo "[+] Completion added to $rc_file"
    fi
}

add_to_rc "$HOME/.bashrc"
add_to_rc "$HOME/.zshrc"

echo ""
echo "[+] Done! Restart your terminal or run:"
echo "    source ~/.bashrc   # for bash"
echo "    source ~/.zshrc    # for zsh"
