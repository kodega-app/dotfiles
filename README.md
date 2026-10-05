# Dotfiles

Modern, high-performance developer dotfiles configured for Linux and macOS.

## Tooling & Language Support

| Tool / Language | LSP Server(s) | Formatter(s) | Features |
| :--- | :--- | :--- | :--- |
| **Go** | `gopls` | `goimports`, `gofumpt` | Inlay hints, struct tag generation (`GoTagAdd`), `if err != nil` generator (`GoIfErr`), doc comments |
| **Python** | `pyright` | `isort`, `black` | Type checking, auto-import completions, PEP 8 formatting, virtualenv support |
| **TypeScript / JS** | `ts_ls` | `prettier` | Inlay hints, TSX/JSX, parameter names, function return hints, auto-imports |
| **Terraform & OpenTofu** | `terraformls`, `tflint` | `terraform_fmt`, `tofu_fmt` | `.tf`, `.tofu`, `.tfvars`, `.hcl` validation, schemas, and formatting |
| **JSON / JSONC / JSON5** | `jsonls` | `prettier` | SchemaStore validation (`package.json`, `tsconfig.json`, `.prettierrc`, etc.) |
| **Markdown** | `marksman` | `prettier` | Heading styling, GitHub callouts (`[!NOTE]`, `[!TIP]`, `[!WARNING]`), Obsidian notes, interactive checkboxes |
| **Docker & Compose** | `dockerls`, `docker_compose_language_service` | — | Dockerfile & compose validation |
| **Ansible** | `ansiblels` | `ansible-lint` | Playbook/role validation, syntax checking, task and module auto-completion |
| **Helm** | `helm_ls` | `prettier` | Chart linting, values auto-completion, Go template syntax, Helm CLI integration |
| **Jenkins** | `groovy` (Treesitter) | `npm-groovy-lint` | Jenkinsfile declarative & scripted pipeline syntax, formatting, and linting |
| **Kubernetes & GitOps** | `yamlls`, `helm_ls` | `prettier` | Kubernetes manifests, CRDs, Argo CD, Flux, K9s management |
| **YAML & CloudFormation** | `yamlls` | `prettier` | Kubernetes & GitHub Actions schema support, AWS CFN custom tags |
| **Bash / Shell** | `bashls` | `shfmt` | Shell script linting and formatting |
| **Lua** | `lua_ls` | `stylua` | Neovim Lua API completions and type diagnostics |

---

## Directory Structure

```
~/dotfiles/
├── nvim/                   # Neovim configuration (LazyVim, Treesitter, LSP, Conform)
│   ├── init.lua
│   ├── lazy-lock.json
│   ├── lazyvim.json
│   └── lua/
│       ├── config/         # Options, Keymaps, Autocmds, Lazy bootstrap
│       └── plugins/        # Custom plugins & theme overrides
├── tmux/                   # Tmux configuration (tmux.conf)
├── kitty/                  # Kitty terminal emulator configuration
├── lazygit/                # LazyGit configuration
├── mise/                   # Mise tool version manager config (Go, Node, Python, Tofu, Terraform)
├── ghostty/                # Ghostty terminal config & themes
├── zsh/                    # Zsh shell configuration (.zshrc)
├── bash/                   # Bash configuration (.bashrc, .profile)
├── install.sh              # Dotfiles symlink & setup script
└── install-essentials.sh   # System dependency bootstrap script
```

---

## Installation

Clone the repository and run the setup script:

```bash
git clone git@github.com:kodega2016/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

---

## Keybindings Reference

### Neovim

Leader Key: `Space` (`<leader>`)

#### General & Navigation
| Key | Mode | Description |
| :--- | :--- | :--- |
| `<leader>w` | Normal | Save current buffer |
| `<leader>q` | Normal | Quit current window |
| `<leader>x` | Normal | Save and quit |
| `<leader>sv` / `<leader>sh` | Normal | Split window vertically / horizontally |
| `<leader>se` / `<leader>sx` | Normal | Make splits equal / close current split |
| `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` | Normal | Seamless Vim & Tmux pane navigation |
| `<S-h>` / `<S-l>` | Normal | Previous / next buffer |
| `<leader>bd` | Normal | Close current buffer |

#### Search & Explorer
| Key | Mode | Description |
| :--- | :--- | :--- |
| `<leader>e` | Normal | Toggle File Explorer (nvim-tree) |
| `<leader>ef` | Normal | Reveal current file in explorer |
| `<leader>ff` | Normal | Find files (Telescope) |
| `<leader>fg` | Normal | Live grep search |
| `<leader>fb` | Normal | Find open buffers |
| `<leader>fr` | Normal | Find recent files |

#### LSP & Code Intelligence
| Key | Mode | Description |
| :--- | :--- | :--- |
| `gd` | Normal | Go to definition |
| `gD` | Normal | Go to declaration |
| `gi` | Normal | Go to implementation |
| `gr` | Normal | Find references |
| `K` | Normal | Hover documentation & signatures |
| `<leader>rn` | Normal | Rename symbol |
| `<leader>ca` | Normal/Visual | Code actions (with diff preview) |
| `<leader>fm` | Normal/Visual | Format buffer or selection |
| `<leader>d` | Normal | Show line diagnostics |
| `]d` / `[d` | Normal | Next / previous diagnostic |
| `<leader>xx` | Normal | Toggle workspace diagnostics (Trouble) |

#### Golang Specific
| Key | Mode | Description |
| :--- | :--- | :--- |
| `<leader>gsj` | Normal | Add JSON struct tags |
| `<leader>gsy` | Normal | Add YAML struct tags |
| `<leader>grm` | Normal | Remove struct tags |
| `<leader>gie` | Normal | Generate `if err != nil` |
| `<leader>gc` | Normal | Generate doc comment |

#### Git, Notes & Terminal
| Key | Mode | Description |
| :--- | :--- | :--- |
| `<leader>gg` | Normal | Open LazyGit |
| `<C-\>` | Normal/Term | Toggle terminal |
| `<leader>ch` | Normal | Toggle Markdown / Obsidian checkbox |
| `<leader>cc` | Normal | Toggle Copilot Chat |

---

### Tmux

Prefix Key: `Ctrl + a`

| Key | Description |
| :--- | :--- |
| `Prefix + \|` | Split window vertically |
| `Prefix + -` | Split window horizontally |
| `Prefix + h/j/k/l` | Navigate panes |
| `Prefix + z` | Zoom / unzoom pane |
| `Prefix + c` | Create new window |
| `Prefix + ,` | Rename window |
| `Prefix + x` | Close current pane |
| `Prefix + r` | Reload tmux configuration |

---

### DevOps & Cloud Native Shell Shortcuts

| Command / Alias | Tool | Description |
| :--- | :--- | :--- |
| `a` / `ap` | Ansible | `ansible` / `ansible-playbook` |
| `apc` / `apv` | Ansible | Dry run check (`--check --diff`) / Syntax check (`--syntax-check`) |
| `avi` / `alint` | Ansible | `ansible-vault` / `ansible-lint` |
| `ans-ping [host]` | Ansible | Ping hosts in inventory |
| `h` / `hls` / `hlsa` | Helm | `helm` / List releases / List in all namespaces |
| `hi` / `hu` / `hdel` | Helm | Install chart / Upgrade or install / Uninstall release |
| `ht` / `hval` | Helm | Template render / Lint chart |
| `hdep` / `hdiff` | Helm | Build dependencies / Diff release against cluster |
| `k` / `kg` / `kgp` | Kubernetes | `kubectl` / `get` / `get pods` |
| `klf` / `ka` / `kd` | Kubernetes | Logs follow / Apply manifest / Delete manifest |
| `k9` / `kx` / `kns` | Kubernetes | Launch `k9s` TUI / Switch context (`kubectx`) / Switch namespace (`kubens`) |
| `jval [file]` | Jenkins | Validate Jenkinsfile syntax via remote Jenkins API or local linter |
| `argo` / `flux-get` | GitOps | `argocd` CLI / Inspect Flux resources |
| `trivy-img` / `trivy-fs` | Security | Scan container image / Scan filesystem for vulnerabilities & misconfigurations |
| `checkov-dir` | Security | Scan IaC templates (Terraform, CloudFormation, Helm, K8s) |
| `act-dry` / `act-job` | CI/CD | Dry-run GitHub Actions locally / Run specific action job with `act` |

