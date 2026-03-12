# Dotfiles

Personal development environment configuration for Linux (WSL2), including Neovim, Tmux, Shell aliases, and automated setup.

## Screenshot

<img width="1663" height="1070" alt="Screenshot 2025-12-07 at 00 01 11" src="https://github.com/user-attachments/assets/b294f8ce-c795-40ae-9891-1d48beb3ed18" />

---

## Directory Structure

```
~/.config/
├── nvim/                  # Neovim configuration (LazyVim)
│   ├── init.lua
│   ├── lazyvim.json
│   ├── lazy-lock.json
│   ├── stylua.toml
│   └── lua/
│       ├── config/
│       │   ├── autocmds.lua
│       │   ├── keymaps.lua
│       │   ├── lazy.lua
│       │   └── options.lua
│       ├── plugins/
│       │   ├── coding.lua
│       │   ├── colorscheme.lua
│       │   ├── editor.lua
│       │   └── ui.lua
│       └── utils/
│           ├── debug.lua
│           └── discipline.lua
├── tmux/                  # Tmux configuration
│   ├── tmux.conf
│   ├── statusline.conf
│   ├── theme.conf
│   ├── utility.conf
│   └── macos.conf
├── shell/                 # Shell aliases
│   └── aliases.sh
├── install.sh             # Automated setup script
└── README.md
```

---

## Quick Start

Clone repo và chạy script cài đặt tự động:

```bash
git clone https://github.com/<your-username>/.config.git ~/.config
cd ~/.config
./install.sh
```

### Install options

```bash
./install.sh                  # Full install
./install.sh --dry-run        # Preview without executing
./install.sh --skip-packages  # Skip apt/tool installation
./install.sh --skip-shell     # Skip oh-my-zsh setup
./install.sh --skip-symlinks  # Skip symlink creation
```

Script sẽ tự động:
- Cài packages: `zsh`, `git`, `ripgrep`, `fd-find`, `tmux`, `nodejs`, `python3`, v.v.
- Cài Neovim (latest), fzf, tmux plugin manager
- Cài oh-my-zsh + plugins + powerlevel10k theme
- Tạo symlinks cho nvim và tmux config
- Cấu hình `.zshrc`

---

## Neovim (`nvim/`)

Dựa trên **LazyVim** framework.

### Plugins

| Category | Plugins |
|---|---|
| Colorscheme | `solarized-osaka` (moon, transparent) |
| LSP | TypeScript, Go, Vue, Tailwind, Prisma, SQL, YAML, HTML, CSS, Lua |
| AI | Copilot, Copilot Chat |
| Code tools | Neogen, refactoring.nvim, incremental-rename, symbols-outline |
| UI | Telescope, Bufferline, Incline, Lualine, Neo-tree, Noice, Zen mode |

### Key Mappings

| Key | Action |
|---|---|
| `;f` | Find files |
| `;r` | Live grep |
| `;e` | Diagnostics |
| `;s` | Treesitter symbols |
| `sf` | File browser |
| `<Leader>cc` | Generate annotations |
| `<Leader>r` | Refactor (visual) |
| `<Leader>at` | Toggle Copilot Chat |
| `<Leader>z` | Zen mode |
| `<Tab>` / `<S-Tab>` | Buffer navigation |

### Custom Copilot Prompts

- `Explain` — Giải thích code bằng tiếng Việt
- `Fix` — Phân tích và sửa lỗi
- `Review` — Code review toàn diện
- `Grammar` — Sửa ngữ pháp tiếng Việt
- `Commit` — Sinh commit message
- `NewBranch` — Sinh tên branch

### Formatters & Linters

`stylua` · `eslint` · `prettier` · `shellcheck` · `shfmt`

---

## Tmux (`tmux/`)

Prefix key: `C-t`

### Key Bindings

| Key | Action |
|---|---|
| `r` | Reload config |
| `h/j/k/l` | Navigate panes (vim-like) |
| `C-h/j/k/l` | Resize panes |
| `\|` | Split vertical |
| `-` | Split horizontal |
| `M-1..9` | Jump to pane by number |
| `C-S-Left/Right` | Move windows |
| `g` | LazyGit popup |
| `M-t` | Dev terminal popup |

### Config files

| File | Purpose |
|---|---|
| `tmux.conf` | Main config, key bindings |
| `statusline.conf` | Status bar layout & styling |
| `theme.conf` | Solarized 256 color scheme |
| `utility.conf` | Popup windows (lazygit, terminal) |
| `macos.conf` | macOS-specific overrides |

---

## Shell (`shell/aliases.sh`)

### Git

| Alias | Command |
|---|---|
| `g` | `git` |
| `gs` | `git status` |
| `ga` | `git add .` |
| `gc` | `git commit --no-verify -m` |
| `gca` | `git commit --no-verify --amend -m` |
| `gp` | `git push origin` |
| `gpf` | `git push -f origin` |
| `gco` | `git checkout` |
| `gcm` | `git checkout master && git pull` |
| `gl` | `git log --oneline --graph` |

### Tmux

| Alias | Command |
|---|---|
| `tnew` | `tmux new -s` |
| `tls` | `tmux ls` |
| `ta` | `tmux attach -t` |
| `td` | `tmux detach` |
| `tk` | `tmux kill-session` |

### DevPod

| Alias | Command |
|---|---|
| `dp` | `devpod` |
| `dpu` | `devpod up` |
| `dpd` | `devpod down` |
| `dps` | `devpod ssh` |
| `dpl` | `devpod list` |
| `dpk` | `devpod stop` |
| `dpr` | `devpod reset` |
| `dpdel` | `devpod delete` |

### Misc

| Alias | Command |
|---|---|
| `vim` | `nvim` |
| `cls` | `clear` |
| `update` | `sudo apt update` |
| `upgrade` | `sudo apt upgrade -y` |
| `wp` | `cd ~/workspaces && ls` |
| `config` | `cd ~/.config` |

---

## Theme

- **Neovim**: Solarized Osaka — moon style, transparent background
- **Tmux**: Solarized 256 colors
- **Terminal**: `xterm-256color` with true color support
