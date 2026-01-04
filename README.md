# Configuration Documentation

Minimal configuration for DevOps, Go, and Flutter development.

## Setup

### Theme
Catppuccin Mocha across all tools (Neovim, Ghostty, tmux)

### Font
JetBrains Mono 14pt

### Tools
- Neovim (LazyVim)
- tmux
- Ghostty terminal
- Zsh shell

## Neovim Keybindings

Leader Key: Space

### General

| Key | Mode | Description |
|-----|------|-------------|
| jk | Insert | Exit insert mode |
| Space + nh | Normal | Clear search highlights |
| Space + sv | Normal | Split window vertically |
| Space + sh | Normal | Split window horizontally |
| Space + sx | Normal | Close current split |
| Tab | Normal | Next buffer |
| Shift + Tab | Normal | Previous buffer |

### File Explorer (Neo-tree)

| Key | Description |
|-----|-------------|
| Space + e | Toggle file explorer |
| Space + E | Toggle on current file |
| a | Add file/folder |
| d | Delete |
| r | Rename |
| y | Copy to clipboard |
| x | Cut to clipboard |
| p | Paste from clipboard |
| R | Refresh |
| ? | Show help |

### Search (Telescope)

| Key | Description |
|-----|-------------|
| Space + ff | Find files |
| Space + fg | Live grep |
| Space + fb | Find buffers |
| Space + fh | Find help |
| Space + fr | Recent files |
| Space + fp | Find projects |
| Space + sg | Search in directory |

### Go Development

| Key | Description |
|-----|-------------|
| Space + gsj | Add JSON tags to struct |
| Space + gsy | Add YAML tags to struct |
| Space + gee | Generate if err != nil |
| Space + cr | Rename symbol |
| Space + ca | Code actions |

### Git

| Key | Description |
|-----|-------------|
| Space + gg | LazyGit |
| Space + gd | DiffView |
| Space + gh | DiffView file history |
| Space + gb | Git blame line |
| Space + gs | Git status |

### Kubernetes & DevOps

| Key | Description |
|-----|-------------|
| Space + k | Toggle kubectl manager |
| Space + rr | REST client run request |

### Obsidian Notes

Workspaces: vault, inbox, projects, areas, resources, archive

| Key | Description |
|-----|-------------|
| Space + ow | Switch workspace |
| Space + od | Today's daily note |
| Space + on | New note (select workspace + template) |
| Space + onp | New project |
| Space + onm | New meeting |
| Space + onl | New learning |
| Space + of | Find notes |
| Space + os | Search notes |
| Space + ol | Follow link |
| Space + ox | Toggle checkbox |
| Space + oti | Insert template |

### Terminal

| Key | Mode | Description |
|-----|------|-------------|
| Space + tt | Normal | Toggle terminal |
| Space + tv | Normal | Toggle vertical terminal |
| jk | Terminal | Exit terminal mode |
| Ctrl + h/j/k/l | Terminal | Navigate to window |

### LSP

| Key | Description |
|-----|-------------|
| gd | Go to definition |
| gr | Go to references |
| gi | Go to implementation |
| K | Hover documentation |
| Space + ca | Code actions |
| Space + cr | Rename symbol |
| Space + cf | Format code |
| [d | Previous diagnostic |
| ]d | Next diagnostic |
| Space + cd | Show diagnostics |

### Window Navigation

| Key | Description |
|-----|-------------|
| Ctrl + h | Move to left window |
| Ctrl + j | Move to bottom window |
| Ctrl + k | Move to top window |
| Ctrl + l | Move to right window |
| Ctrl + Up | Increase window height |
| Ctrl + Down | Decrease window height |
| Ctrl + Left | Decrease window width |
| Ctrl + Right | Increase window width |

## tmux Keybindings

Prefix Key: Ctrl + a

### Sessions

| Key | Action |
|-----|--------|
| Ctrl + a d | Detach from session |
| Ctrl + a $ | Rename session |
| Ctrl + a s | List sessions |

### Windows

| Key | Action |
|-----|--------|
| Ctrl + a c | Create new window |
| Ctrl + a , | Rename window |
| Ctrl + a & | Close window |
| Shift + Left | Previous window (no prefix) |
| Shift + Right | Next window (no prefix) |
| Ctrl + a 0-9 | Switch to window number |
| Ctrl + a w | List windows |

### Panes

| Key | Action |
|-----|--------|
| Ctrl + a \| | Split vertically |
| Ctrl + a - | Split horizontally |
| Ctrl + a x | Close pane |
| Alt + Arrow | Switch panes (no prefix) |
| Ctrl + a h/j/k/l | Switch panes (vim keys) |
| Ctrl + a H/J/K/L | Resize pane |
| Ctrl + a z | Zoom/unzoom pane |
| Ctrl + a { | Move pane left |
| Ctrl + a } | Move pane right |

### Copy Mode

| Key | Action |
|-----|--------|
| Ctrl + a [ | Enter copy mode |
| v | Start selection |
| y | Copy selection |
| q | Exit copy mode |
| Ctrl + a ] | Paste |

### Utilities

| Key | Action |
|-----|--------|
| Ctrl + a r | Reload config |
| Ctrl + a ? | List all keybindings |
| Ctrl + a t | Show time |
| Ctrl + a : | Enter command mode |

## Installation

### Install essentials
```bash
~/.config/install-essentials.sh
```

### Configure shell
```bash
echo "source ~/.config/shell-config-minimal.zsh" >> ~/.zshrc
source ~/.zshrc
```

### Create tmux symlink
```bash
ln -sf ~/.config/tmux/tmux.conf ~/.tmux.conf
```

### Launch Neovim
```bash
nvim
```

## File Locations

- Neovim: `~/.config/nvim/`
- tmux: `~/.config/tmux/tmux.conf`
- Ghostty: `~/.config/ghostty/config`
- Shell: `~/.config/shell-config-minimal.zsh`

## Version Managers

- tfenv: Terraform version management
- nvm: Node.js version management

## Notes Structure (PARA)

```
~/Documents/workspace/khadga/notes/
├── 0-Inbox/
│   └── daily/
├── 1-Projects/
├── 2-areas/
├── 3-resources/
└── 4-archive/
```

---

Configuration optimized for DevOps, Go, and Flutter development on macOS.
