#!/usr/bin/env bash
# =============================================================================
# Cross-Platform Developer Setup Script (macOS & Linux)
# Sets up Homebrew, Mise, Neovim, Tmux, Terminal, and Development Toolchains
# =============================================================================
set -euo pipefail

echo "=========================================="
echo " Starting Developer Environment Setup"
echo "=========================================="

OS="$(uname -s)"
case "$OS" in
    Darwin)
        PLATFORM="macos"
        ;;
    Linux)
        PLATFORM="linux"
        ;;
    *)
        echo "Unsupported operating system: $OS"
        exit 1
        ;;
esac

echo "Detected OS: $PLATFORM ($OS)"

# -----------------------------------------------------------------------------
# 1. Package Manager (Homebrew)
# -----------------------------------------------------------------------------
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [ -x "/opt/homebrew/bin/brew" ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi
else
    echo "Homebrew already installed"
fi

# -----------------------------------------------------------------------------
# 2. Core CLI Tools
# -----------------------------------------------------------------------------
echo "Installing core CLI tools..."
brew install git curl wget ripgrep fd fzf bat tree-sitter neovim tmux lazygit mise fastfetch

# -----------------------------------------------------------------------------
# 3. Development Toolchains via Mise
# -----------------------------------------------------------------------------
echo "Setting up Mise toolchains (Go, Node, Python, Terraform, OpenTofu, UV)..."
eval "$(mise activate bash)"
mise install -y

# -----------------------------------------------------------------------------
# 4. Go Development Tools
# -----------------------------------------------------------------------------
echo "Installing Go developer tools..."
go install golang.org/x/tools/gopls@latest
go install github.com/go-delve/delve/cmd/dlv@latest
go install github.com/golangci/golangci-lint/v2/cmd/golangci-lint@latest || go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
go install github.com/fatih/gomodifytags@latest
go install github.com/josharian/impl@latest
go install github.com/koron/iferr@latest
go install github.com/cweill/gotests/...@latest

# Reshim mise
mise reshim

# -----------------------------------------------------------------------------
# 5. Link Dotfiles
# -----------------------------------------------------------------------------
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "Linking dotfiles from $DOTFILES_DIR..."
"$DOTFILES_DIR/install.sh"

echo ""
echo "=========================================="
echo " Setup complete!"
echo " Restart your terminal or run: source ~/.zshrc"
echo "=========================================="
