export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

[ -f "$ZSH/oh-my-zsh.sh" ] && source "$ZSH/oh-my-zsh.sh"

# Homebrew environment (macOS Apple Silicon, macOS Intel, Linuxbrew)
if [ -x "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [ -x "/usr/local/bin/brew" ]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

# PATH setup
export PATH="$HOME/.local/share/mise/shims:$HOME/.local/bin:$HOME/go/bin:$PATH"

# Mise version manager activation
if command -v mise &> /dev/null; then
    eval "$(mise activate zsh)"
elif [ -x "$HOME/.local/bin/mise" ]; then
    eval "$("$HOME/.local/bin/mise" activate zsh)"
fi

# Linux clipboard fallback (macOS has native pbcopy/pbpaste)
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if command -v xclip &> /dev/null; then
        alias pbcopy='xclip -selection clipboard'
        alias pbpaste='xclip -selection clipboard -o'
    elif command -v wl-copy &> /dev/null; then
        alias pbcopy='wl-copy'
        alias pbpaste='wl-paste'
    fi
fi

# Display fastfetch if installed
command -v fastfetch &> /dev/null && fastfetch
