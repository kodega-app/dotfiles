#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"

echo "=========================================="
echo " Setting up Dotfiles from $DOTFILES_DIR"
echo "=========================================="

mkdir -p "$CONFIG_DIR"

# 1. Neovim
echo "Linking Neovim config..."
mkdir -p "$CONFIG_DIR/nvim"
rm -rf "$CONFIG_DIR/nvim"
ln -sf "$DOTFILES_DIR/nvim" "$CONFIG_DIR/nvim"

# 2. Tmux
echo "Linking Tmux config..."
mkdir -p "$CONFIG_DIR/tmux"
ln -sf "$DOTFILES_DIR/tmux/tmux.conf" "$CONFIG_DIR/tmux/tmux.conf"
ln -sf "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"
ln -sfn "$DOTFILES_DIR/tmux/themes" "$CONFIG_DIR/tmux/themes"

# 3. Ghostty
echo "Linking Ghostty config..."
mkdir -p "$CONFIG_DIR/ghostty"
ln -sf "$DOTFILES_DIR/ghostty/config" "$CONFIG_DIR/ghostty/config"
if [ -d "$DOTFILES_DIR/ghostty/themes" ]; then
    ln -sfn "$DOTFILES_DIR/ghostty/themes" "$CONFIG_DIR/ghostty/themes"
fi

# Clean up legacy Kitty symlinks if present
if [ -d "$CONFIG_DIR/kitty" ]; then
    echo "Cleaning up legacy Kitty configuration..."
    rm -f "$CONFIG_DIR/kitty/kitty.conf" "$CONFIG_DIR/kitty/current-theme.conf" "$CONFIG_DIR/kitty/themes"
    rmdir "$CONFIG_DIR/kitty" 2>/dev/null || true
fi

# Helper scripts & binaries
mkdir -p "$HOME/.local/bin"
ln -sf "$DOTFILES_DIR/scripts/theme-manager.sh" "$HOME/.local/bin/theme-manager"
ln -sf "$DOTFILES_DIR/scripts/theme-manager.sh" "$HOME/.local/bin/switch-theme"
if [ -x "/Applications/Ghostty.app/Contents/MacOS/ghostty" ]; then
    ln -sf "/Applications/Ghostty.app/Contents/MacOS/ghostty" "$HOME/.local/bin/ghostty"
fi

# 4. LazyGit
echo "Linking LazyGit config..."
mkdir -p "$CONFIG_DIR/lazygit"
ln -sf "$DOTFILES_DIR/lazygit/config.yml" "$CONFIG_DIR/lazygit/config.yml"

# 5. Mise
echo "Linking Mise config..."
mkdir -p "$CONFIG_DIR/mise"
ln -sf "$DOTFILES_DIR/mise/config.toml" "$CONFIG_DIR/mise/config.toml"

# 6. Powerlevel10k prompt
if [ -d "$HOME/.oh-my-zsh" ] && [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
    echo "Cloning Powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" 2>/dev/null || true
fi
if [ -f "$DOTFILES_DIR/zsh/.p10k.zsh" ]; then
    echo "Linking Powerlevel10k config..."
    ln -sf "$DOTFILES_DIR/zsh/.p10k.zsh" "$HOME/.p10k.zsh"
fi

# 7. Shell configs
echo "Linking Shell configs..."
ln -sf "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/bash/.bashrc" "$HOME/.bashrc"
ln -sf "$DOTFILES_DIR/bash/.profile" "$HOME/.profile"
mkdir -p "$CONFIG_DIR/shell"
ln -sf "$DOTFILES_DIR/shell-config-minimal.zsh" "$CONFIG_DIR/shell/aliases.sh"

# 8. Systemd User Services (Auto Theme Synchronizer for Linux)
if command -v systemctl &>/dev/null && [ -d "$DOTFILES_DIR/systemd/user" ]; then
    echo "Configuring Theme Synchronizer background service..."
    mkdir -p "$CONFIG_DIR/systemd/user"
    ln -sf "$DOTFILES_DIR/systemd/user/theme-listener.service" "$CONFIG_DIR/systemd/user/theme-listener.service"
    systemctl --user daemon-reload 2>/dev/null || true
    systemctl --user enable --now theme-listener.service 2>/dev/null || true
fi

# Run initial theme sync based on current system appearance
"$DOTFILES_DIR/scripts/theme-manager.sh" auto false 2>/dev/null || true

echo ""
echo "=========================================="
echo " Dotfiles setup complete!"
echo "=========================================="
