export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# export MANPATH="/usr/local/man:$MANPATH"

# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

fastfetch

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
export PATH="$HOME/.local/share/mise/shims:$HOME/.local/bin:$HOME/go/bin:$PATH"
eval "$(/home/kode/.local/bin/mise activate zsh)"

