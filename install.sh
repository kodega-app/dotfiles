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

# 3. Kitty
echo "Linking Kitty config..."
mkdir -p "$CONFIG_DIR/kitty"
ln -sf "$DOTFILES_DIR/kitty/kitty.conf" "$CONFIG_DIR/kitty/kitty.conf"
ln -sf "$DOTFILES_DIR/kitty/current-theme.conf" "$CONFIG_DIR/kitty/current-theme.conf"
ln -sfn "$DOTFILES_DIR/kitty/themes" "$CONFIG_DIR/kitty/themes"

# Helper scripts
mkdir -p "$HOME/.local/bin"
ln -sf "$DOTFILES_DIR/scripts/theme-manager.sh" "$HOME/.local/bin/theme-manager"
ln -sf "$DOTFILES_DIR/scripts/theme-manager.sh" "$HOME/.local/bin/switch-theme"


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

# 7. Starship prompt
if [ -f "$DOTFILES_DIR/starship/starship.toml" ]; then
    echo "Linking Starship config..."
    ln -sf "$DOTFILES_DIR/starship/starship.toml" "$CONFIG_DIR/starship.toml"
fi

# 8. Window Manager & Desktop (i3, Polybar, Rofi)
if [ -d "$DOTFILES_DIR/i3" ]; then
    echo "Linking i3 config..."
    ln -sfn "$DOTFILES_DIR/i3" "$CONFIG_DIR/i3"
fi
if [ -d "$DOTFILES_DIR/polybar" ]; then
    echo "Linking Polybar config..."
    ln -sfn "$DOTFILES_DIR/polybar" "$CONFIG_DIR/polybar"
fi
if [ -d "$DOTFILES_DIR/rofi" ]; then
    echo "Linking Rofi config..."
    ln -sfn "$DOTFILES_DIR/rofi" "$CONFIG_DIR/rofi"
fi
if [ -d "$DOTFILES_DIR/fontconfig" ]; then
    echo "Linking Fontconfig config..."
    ln -sfn "$DOTFILES_DIR/fontconfig" "$CONFIG_DIR/fontconfig"
    mkdir -p "$HOME/.local/share/fonts"
    ln -sfn "$HOME/.local/share/fonts" "$HOME/.fonts"
fi

# 8. Shell configs
echo "Linking Shell configs..."
ln -sf "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/bash/.bashrc" "$HOME/.bashrc"
ln -sf "$DOTFILES_DIR/bash/.profile" "$HOME/.profile"

# 9. Systemd User Services (Auto Theme Synchronizer)
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

