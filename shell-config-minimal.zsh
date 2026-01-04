# Minimal Zsh Configuration
# Add to ~/.zshrc

# Path
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

# Go
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"

# Flutter
export PATH="$PATH:$HOME/flutter/bin"

# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# tfenv (Terraform Version Manager)
export PATH="$HOME/.tfenv/bin:$PATH"

# Editor
export EDITOR="nvim"
export VISUAL="nvim"

# Aliases - Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias dev='cd ~/Developer'
alias config='cd ~/.config'

# Aliases - Git
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias lg='lazygit'

# Aliases - Docker
alias d='docker'
alias dc='docker-compose'
alias dps='docker ps'
alias di='docker images'
alias dex='docker exec -it'

# Aliases - Kubernetes
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgd='kubectl get deployments'
alias kgn='kubectl get nodes'
alias kdp='kubectl describe pod'
alias kl='kubectl logs'
alias kx='kubectx'
alias kns='kubens'

# Aliases - Terraform
alias tf='terraform'
alias tfi='terraform init'
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tfd='terraform destroy'
alias tfv='terraform validate'
alias tfenv-list='tfenv list'
alias tfenv-use='tfenv use'
alias tfenv-install='tfenv install'

# Aliases - Go
alias gor='go run'
alias gob='go build'
alias got='go test'
alias gom='go mod'
alias gof='go fmt'

# Aliases - Flutter
alias fl='flutter'
alias flr='flutter run'
alias flb='flutter build'
alias flt='flutter test'
alias flc='flutter clean'
alias fld='flutter doctor'

# Aliases - System
alias update='brew update && brew upgrade && brew cleanup'
alias cleanup='docker system prune -a && go clean -cache -modcache'
alias ports='lsof -i -P | grep LISTEN'

# Functions
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Git commit with message
gcm() {
    git commit -m "$1"
}

# Docker cleanup
dclean() {
    docker system prune -af --volumes
}

# Find process on port
port() {
    lsof -i :"$1"
}

# Minimal prompt (if not using oh-my-zsh)
# PROMPT='%F{blue}%~%f %F{green}❯%f '

