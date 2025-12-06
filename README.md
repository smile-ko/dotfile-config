# Dotfiles Configuration

Dotfiles configuration for development environment, including Neovim, Tmux, Shell aliases, and utility scripts.

## 📸 Screenshot
<img width="1663" height="1070" alt="Screenshot 2025-12-07 at 00 01 11" src="https://github.com/user-attachments/assets/b294f8ce-c795-40ae-9891-1d48beb3ed18" />

## 📁 Directory Structure

```
.config/
├── nvim/          # Neovim configuration
├── tmux/          # Tmux configuration
├── shell/         # Shell aliases
└── script/        # Utility scripts
```

---

## 🚀 Neovim Configuration (`nvim/`)

Neovim configuration based on **LazyVim** with many plugins and customizations.

### Structure

```
nvim/
├── init.lua                    # Entry point, bootstrap LazyVim
├── lazyvim.json                # LazyVim configuration
├── lazy-lock.json              # Plugin lock file
├── stylua.toml                 # Lua formatter config
├── .gitignore                  # Git ignore patterns
├── .neoconf.json               # Neodev & Neoconf settings
└── lua/
    ├── config/
    │   ├── autocmds.lua        # Auto commands
    │   ├── keymaps.lua         # Custom key mappings
    │   ├── lazy.lua            # LazyVim plugin setup
    │   └── options.lua          # Neovim options
    ├── plugins/
    │   ├── coding.lua          # Coding plugins (LSP, Treesitter, etc.)
    │   ├── colorscheme.lua     # Colorscheme config
    │   ├── editor.lua          # Editor enhancements
    │   └── ui.lua              # UI plugins
    └── utils/
        ├── debug.lua           # Debug utilities
        └── discipline.lua      # Cowboy mode (anti-spam keys)
```

### Key Features

#### **Plugins & Extensions**

- **LazyVim Base**: Main framework
- **Colorscheme**: `solarized-osaka` (moon style, transparent)
- **LSP Servers**: TypeScript, Go, Vue, Tailwind, Prisma, SQL, YAML, CMake, HTML, CSS, Lua
- **AI Support**: Copilot & Copilot Chat with custom prompts (Vietnamese)
- **Code Tools**:
  - Neogen (annotations)
  - Refactoring.nvim
  - Incremental rename
  - Symbols outline
- **UI Enhancements**:
  - Telescope (file browser, fuzzy finder)
  - Bufferline
  - Incline (filename display)
  - Lualine (statusline)
  - Neo-tree (file explorer)
  - Zen mode
  - Noice (messages/notifications)

#### **Key Mappings**

- `<Leader>` = Space
- `;f` - Find files
- `;r` - Live grep
- `;t` - Help tags
- `;e` - Diagnostics
- `;s` - Treesitter symbols
- `sf` - File browser
- `<Leader>cc` - Generate annotations
- `<Leader>r` - Refactor (visual mode)
- `<Leader>at` - Toggle Copilot Chat
- `<Leader>z` - Zen mode
- `<Tab>` / `<S-Tab>` - Buffer navigation

#### **Custom Features**

- **Cowboy Mode**: Warns when pressing keys too many times
- **Custom Copilot Prompts**:
  - `Explain` - Explain code in Vietnamese
  - `Fix` - Analyze and fix errors
  - `Review` - Comprehensive code review
  - `Grammar` - Fix Vietnamese grammar
  - `Commit` - Generate commit message
  - `NewBranch` - Generate branch name

#### **Formatter & Linter**

- Stylua (Lua)
- ESLint
- Prettier
- Shellcheck, shfmt

---

## 🎯 Tmux Configuration (`tmux/`)

Tmux configuration with prefix key `C-t` and many customizations.

### Structure

```
tmux/
├── tmux.conf          # Main configuration
├── statusline.conf    # Status bar styling
├── theme.conf         # Color theme (Solarized)
├── utility.conf       # Utility bindings (lazygit, popup)
└── macos.conf         # macOS-specific settings
```

### Key Features

#### **Key Bindings**

- **Prefix**: `C-t` (instead of default `C-b`)
- **Reload**: `r` - Reload config
- **Pane Navigation**: `h/j/k/l` - Vim-like navigation
- **Pane Resize**: `C-h/j/k/l` - Resize panes
- **Split**: `|` (vertical), `-` (horizontal)
- **Select Pane**: `M-1` to `M-9` - Jump to pane by number
- **Window Swap**: `C-S-Left/Right` - Move windows
- **Copy Mode**: `y` in copy-mode - Copy to clipboard (macOS)

#### **Status Bar**

- Displays session name, username, hostname
- Window list with current path
- Solarized color scheme
- Custom separators and styling

#### **Utilities**

- `g` - LazyGit popup (80% window)
- `M-t` - Dev terminal popup (85% window)
- Auto-detect macOS and load `macos.conf`

#### **Theme**

- Solarized 256 color scheme
- Custom pane borders
- Window status colors
- Message styling

---

## 🐚 Shell Aliases (`shell/aliases.sh`)

Collection of useful shell aliases.

### Categories

#### **Git Aliases**

- `g` - git
- `gs` - git status
- `gb` - git branch
- `gr` - git remote -v
- `ga` - git add .
- `gc` - git commit --no-verify -m
- `gca` - git commit --no-verify --amend -m
- `gp` - git push origin
- `gpf` - git push -f origin
- `gco` - git checkout
- `gcm` - git checkout master && git pull
- `gl` - git log --oneline --graph

#### **Helper Aliases**

- `update` - sudo apt update
- `upgrade` - sudo apt upgrade -y
- `cls` - clear
- `vim` - nvim
- `system` - htop
- `google-s` - Open Google Chrome
- `google` - Open URL in Chrome

#### **Tmux Aliases**

- `tnew` - tmux new -s
- `tls` - tmux ls
- `ta` - tmux attach -t
- `td` - tmux detach
- `tk` - tmux kill-session
- `tsplitv` - Split vertical
- `tsplith` - Split horizontal
- `tleft/tright/tup/tdown` - Navigate panes

#### **Workspace**

- `wp` - cd ~/workspaces && ls
- `cmd` - Run tmux layout script
- `config` - cd ~/.config

---

## 📜 Scripts (`script/`)

### `tmux_layout.sh`

Script that automatically creates a tmux layout with 3 panes:

- Pane 0: Main (left, 70%)
- Pane 1: Top right (30% width, 66% height)
- Pane 2: Bottom right (30% width, 34% height)

**Usage**:

```bash
alias cmd='~/.config/script/tmux_layout.sh'
# Or run directly
~/.config/script/tmux_layout.sh
```

---

## 🎨 Theme & Colors

- **Neovim**: Solarized Osaka (moon style, transparent)
- **Tmux**: Solarized 256 colors
- **Terminal**: xterm-256color

---

## 📝 Notes

- Neovim config uses LazyVim framework
- All plugins are managed by lazy.nvim
- Tmux prefix key is `C-t` instead of default
- Shell aliases need to be sourced in `.zshrc` or `.bashrc`
- macOS-specific settings are automatically loaded in tmux

---

## 🔧 Setup

1. **Neovim**:

   - Clone or symlink `nvim/` to `~/.config/nvim/`
   - Run Neovim, LazyVim will automatically bootstrap

2. **Tmux**:

   - Symlink `tmux.conf` or source it in `~/.tmux.conf`:
     ```bash
     source ~/.config/tmux/tmux.conf
     ```

3. **Shell**:

   - Add to `.zshrc`:
     ```bash
     source ~/.config/shell/aliases.sh
     ```

4. **Scripts**:
   - Ensure scripts have execute permissions:
     ```bash
     chmod +x ~/.config/script/*.sh
     ```

---



