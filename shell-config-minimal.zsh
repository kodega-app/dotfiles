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

# Aliases - Kubernetes & K9s
alias k='kubectl'
alias kg='kubectl get'
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgd='kubectl get deployments'
alias kgn='kubectl get nodes'
alias kdp='kubectl describe pod'
alias kl='kubectl logs'
alias klf='kubectl logs -f'
alias ka='kubectl apply -f'
alias kd='kubectl delete -f'
alias kx='kubectx'
alias kns='kubens'
alias k9='k9s'

# Aliases - Helm
alias h='helm'
alias hls='helm list'
alias hlsa='helm list --all-namespaces'
alias hi='helm install'
alias hu='helm upgrade --install'
alias hdel='helm uninstall'
alias ht='helm template'
alias hval='helm lint'
alias hdep='helm dependency build'
alias hstatus='helm status'
alias hhist='helm history'

# Aliases - Ansible
alias a='ansible'
alias ap='ansible-playbook'
alias apc='ansible-playbook --check --diff'
alias apv='ansible-playbook --syntax-check'
alias avi='ansible-vault'
alias avie='ansible-vault edit'
alias aviv='ansible-vault view'
alias agal='ansible-galaxy'
alias alint='ansible-lint'

# Aliases - Jenkins & CI/CD
alias jcli='jenkins-cli'
alias act-dry='act -n'
alias act-job='act -j'
alias argo='argocd'
alias flux-get='flux get all'

# Aliases - Security & Scanners (Trivy, Checkov)
alias trivy-img='trivy image'
alias trivy-fs='trivy fs --security-checks vuln,config .'
alias checkov-dir='checkov -d .'

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

# Aliases - AWS & CloudFormation
alias aws-who='aws sts get-caller-identity'
alias cfn='aws cloudformation'
alias cfn-ls='aws cloudformation list-stacks --stack-status-filter CREATE_COMPLETE UPDATE_COMPLETE ROLLBACK_COMPLETE UPDATE_ROLLBACK_COMPLETE IMPORT_COMPLETE'
alias cfn-desc='aws cloudformation describe-stacks --stack-name'
alias cfn-events='aws cloudformation describe-stack-events --stack-name'
alias cfn-res='aws cloudformation describe-stack-resources --stack-name'
alias cfn-val='aws cloudformation validate-template --template-body'
alias cfn-deploy='aws cloudformation deploy'
alias cfn-del='aws cloudformation delete-stack --stack-name'
alias cfn-cs='aws cloudformation create-change-set'
alias cfn-lint='cfn-lint'

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
unalias gcm 2>/dev/null
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

# AWS CloudFormation stack outputs
cfn-out() {
    aws cloudformation describe-stacks --stack-name "$1" --query "Stacks[0].Outputs[*].[OutputKey,OutputValue,Description]" --output table
}

# AWS CloudFormation recent stack events
cfn-tail() {
    aws cloudformation describe-stack-events --stack-name "$1" --query "StackEvents[:15].[Timestamp,LogicalResourceId,ResourceType,ResourceStatus,ResourceStatusReason]" --output table
}

# AWS CloudFormation validate local template
cfn-validate() {
    aws cloudformation validate-template --template-body "file://$1"
}

# Ansible quick ping
ans-ping() {
    ansible "${1:-all}" -m ping ${2:+-i "$2"}
}

# Helm diff against deployed release
hdiff() {
    helm diff upgrade "$1" "$2"
}

# Jenkinsfile syntax validator
jval() {
    local jf="${1:-Jenkinsfile}"
    if [ ! -f "$jf" ]; then
        echo "Error: File $jf not found"
        return 1
    fi
    if [ -n "${JENKINS_URL:-}" ]; then
        curl -s -X POST -F "Jenkinsfile=<$jf" "$JENKINS_URL/pipeline-model-converter/validate"
    else
        echo "Tip: Set JENKINS_URL to validate against remote Jenkins, or running 'npm-groovy-lint $jf'"
        if command -v npm-groovy-lint &>/dev/null; then
            npm-groovy-lint "$jf"
        fi
    fi
}

# Minimal prompt (if not using oh-my-zsh)
# PROMPT='%F{blue}%~%f %F{green}❯%f '

