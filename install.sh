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

# 3. Kitty
echo "Linking Kitty config..."
mkdir -p "$CONFIG_DIR/kitty"
ln -sf "$DOTFILES_DIR/kitty/kitty.conf" "$CONFIG_DIR/kitty/kitty.conf"

# 4. LazyGit
echo "Linking LazyGit config..."
mkdir -p "$CONFIG_DIR/lazygit"
ln -sf "$DOTFILES_DIR/lazygit/config.yml" "$CONFIG_DIR/lazygit/config.yml"

# 5. Mise
echo "Linking Mise config..."
mkdir -p "$CONFIG_DIR/mise"
ln -sf "$DOTFILES_DIR/mise/config.toml" "$CONFIG_DIR/mise/config.toml"

# 6. Ghostty (if present)
if [ -d "$DOTFILES_DIR/ghostty" ]; then
    echo "Linking Ghostty config..."
    mkdir -p "$CONFIG_DIR/ghostty"
    ln -sf "$DOTFILES_DIR/ghostty/config" "$CONFIG_DIR/ghostty/config"
fi

# 7. Shell configs
echo "Linking Shell configs..."
ln -sf "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/bash/.bashrc" "$HOME/.bashrc"
ln -sf "$DOTFILES_DIR/bash/.profile" "$HOME/.profile"

echo ""
echo "=========================================="
echo " Dotfiles setup complete!"
echo "=========================================="
