#!/bin/bash

# Essential macOS Setup Script
# For DevOps, Go, and Flutter Development

echo "Starting minimal macOS setup..."
echo ""

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew already installed"
fi

echo ""
echo "Installing essential tools..."
echo ""

# Development tools
echo "Installing development tools..."
brew install git go python3

# Note: Node managed by nvm (skipping)
echo "Skipping node (managed by nvm)"

# Go tools
echo "Installing Go tools..."
go install golang.org/x/tools/gopls@latest
go install github.com/go-delve/delve/cmd/dlv@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest

# DevOps tools
echo "Installing DevOps tools..."
brew install kubectl kubectx k9s ansible docker
brew install jq yq htop btop wget curl httpie

# Note: Terraform managed by tfenv (skipping)
echo "Skipping terraform (managed by tfenv)"

# Note: Helm already installed (skipping)
echo "Skipping helm (already installed)"

# Note: Flutter already installed (skipping)
echo "Skipping flutter (already installed)"

# Terminal tools
echo "Installing terminal tools..."
brew install tmux neovim lazygit

# Productivity
echo "Installing productivity tools..."
brew install --cask rectangle raycast

# Optional: VS Code for Flutter
read -p "Install VS Code? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    brew install --cask visual-studio-code
fi

# Font
echo "Installing JetBrains Mono font..."
brew install --cask font-jetbrains-mono

echo ""
echo "Configuring macOS settings..."
echo ""

# Dock settings
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.5
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock show-recents -bool false

# Finder settings
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Keyboard settings
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# Mission Control
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock mru-spaces -bool false

echo ""
echo "Restarting Dock and Finder..."
killall Dock
killall Finder

echo ""
echo "Setup complete!"
echo ""
echo "Next steps:"
echo "1. Restart Ghostty to apply font changes"
echo "2. Configure Rectangle keyboard shortcuts"
echo "3. Set up Raycast preferences"
echo "4. Install Flutter dependencies: flutter doctor"
echo "5. Configure Git: git config --global user.name 'Your Name'"
echo "6. Configure Git: git config --global user.email 'your@email.com'"
echo ""
echo "See MAC_SETUP.md for detailed configuration"

