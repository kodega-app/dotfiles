# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ==============================================================================
# Zsh Shell Configuration
# Developer Workflow & Performance Setup (Powerlevel10k & Oh-My-Zsh)
# ==============================================================================

# Oh My Zsh configuration
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

# History configuration
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt EXTENDED_HISTORY          # Write timestamps to history
setopt SHARE_HISTORY             # Share history across sessions
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first
setopt HIST_IGNORE_DUPS          # Don't record consecutive duplicate commands
setopt HIST_IGNORE_ALL_DUPS      # Delete older duplicate entries
setopt HIST_FIND_NO_DUPS         # Do not display duplicates in search
setopt HIST_IGNORE_SPACE         # Don't record commands starting with space
setopt HIST_SAVE_NO_DUPS         # Don't save duplicates
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks

# Autosuggestions configuration (loaded via Oh-My-Zsh plugin)
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=244"
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

plugins=(
    git
    zsh-autosuggestions
)

[ -f "$ZSH/oh-my-zsh.sh" ] && source "$ZSH/oh-my-zsh.sh"

# Keybindings for autosuggestions
bindkey '^ ' autosuggest-accept        # Ctrl+Space to accept full suggestion
bindkey '^@' autosuggest-accept        # Ctrl+Space fallback (NUL)
bindkey '^f' autosuggest-accept        # Ctrl+F to accept full suggestion
bindkey '^e' autosuggest-accept        # Ctrl+E to accept full suggestion
bindkey '^y' autosuggest-execute       # Ctrl+Y to accept and execute suggestion
bindkey '^[f' forward-word             # Alt+F to accept next word
bindkey '^[[1;3C' forward-word         # Alt+Right Arrow to accept next word
bindkey '^[[1;5C' forward-word         # Ctrl+Right Arrow to accept next word

# Homebrew environment (macOS Apple Silicon, macOS Intel, Linuxbrew)
if [ -x "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [ -x "/usr/local/bin/brew" ]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

# PATH deduplication and clean prioritization
typeset -U path PATH
path=(
    "$HOME/.local/share/mise/shims"
    "$HOME/.local/bin"
    "$HOME/go/bin"
    "$HOME/.lmstudio/bin"
    "/opt/nvim-linux-x86_64/bin"
    $path
)
export PATH

# Default Editor
export EDITOR="nvim"
export VISUAL="nvim"

# Mise version manager activation
if command -v mise &> /dev/null; then
    eval "$(mise activate zsh)"
elif [ -x "$HOME/.local/bin/mise" ]; then
    eval "$("$HOME/.local/bin/mise" activate zsh)"
fi

# Linux clipboard fallback (macOS has native pbcopy/pbpaste)
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if command -v wl-copy &> /dev/null; then
        alias pbcopy='wl-copy'
        alias pbpaste='wl-paste'
    elif command -v xclip &> /dev/null; then
        alias pbcopy='xclip -selection clipboard'
        alias pbpaste='xclip -selection clipboard -o'
    fi
fi

# FZF Integration & Solarized Osaka Theme (Transparent & Fast)
if command -v fzf &>/dev/null; then
    eval "$(fzf --zsh)"

    export FZF_DEFAULT_OPTS=" \
      --color=bg:-1,bg+:#002c38,border:#063540,spinner:#c94c16 \
      --color=hl:#268bd3,fg:#9eabac,header:#576d74,info:#29a298,pointer:#268bd3 \
      --color=marker:#29a298,fg+:#fdf5e2,prompt:#268bd3,hl+:#268bd3 \
      --prompt='❯ ' --pointer='▶' --marker='✓' \
      --height=45% --layout=reverse --border=rounded --inline-info"

    if command -v fd &>/dev/null; then
        export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_ALT_C_COMMAND='fd --type d --strip-cwd-prefix --hidden --follow --exclude .git'
    fi

    if command -v bat &>/dev/null; then
        export BAT_THEME="Solarized (dark)"
        export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :300 {} 2>/dev/null || cat {} 2>/dev/null | head -300'"
        export FZF_ALT_C_OPTS="--preview 'tree -C {} 2>/dev/null | head -200'"
    fi
fi

# Zoxide smart directory jumping (z <dir>, zi with fzf interactive)
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh)"
fi

# Eza modern ls replacement with icons & git status
if command -v eza &>/dev/null; then
    alias ls='eza --icons --group-directories-first'
    alias l='eza -lh --icons --group-directories-first'
    alias ll='eza -lha --icons --group-directories-first --git'
    alias la='eza -a --icons --group-directories-first'
    alias lt='eza --tree --level=2 --icons'
    alias ltree='eza --tree --level=3 --icons'
fi



# Shared developer aliases (Docker, K8s, Terraform, Go, Git)
if [ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliases.sh" ]; then
    source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliases.sh"
elif [ -f "$HOME/dotfiles/shell-config-minimal.zsh" ]; then
    source "$HOME/dotfiles/shell-config-minimal.zsh"
fi

# Display fastfetch on initial interactive terminal (skip in tmux subpanes)
if [[ -o interactive ]] && command -v fastfetch &> /dev/null && [[ -z "${TMUX:-}" ]]; then
    fastfetch
fi

# Syntax highlighting (must be loaded last, after all widgets, aliases, and prompt)
if [ -f "$ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh" ]; then
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
    source "$ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# Added by Antigravity CLI installer
export PATH="/Users/kode/.local/bin:$PATH"
