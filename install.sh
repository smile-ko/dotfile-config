#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"
LOG_FILE="$DOTFILES_DIR/install.log"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

# Flags
SKIP_PACKAGES=false
SKIP_SYMLINKS=false
SKIP_SHELL=false
DRY_RUN=false

# Helpers
log() { echo -e "${BLUE}[INFO]${RESET} $*" | tee -a "$LOG_FILE"; }
success() { echo -e "${GREEN}[OK]${RESET}   $*" | tee -a "$LOG_FILE"; }
warn() { echo -e "${YELLOW}[WARN]${RESET} $*" | tee -a "$LOG_FILE"; }
error() { echo -e "${RED}[ERR]${RESET}  $*" | tee -a "$LOG_FILE"; }
step() { echo -e "\n${BOLD}${CYAN}▶ $*${RESET}" | tee -a "$LOG_FILE"; }

run() {
  if [[ "$DRY_RUN" == true ]]; then
    echo -e "${YELLOW}[DRY-RUN]${RESET} $*"
  else
    eval "$@"
  fi
}

command_exists() { command -v "$1" &>/dev/null; }

print_usage() {
  echo -e "${BOLD}Usage:${RESET} $0 [OPTIONS]"
  echo ""
  echo "Options:"
  echo "  --skip-packages   Skip package installation"
  echo "  --skip-symlinks   Skip symlink creation"
  echo "  --skip-shell      Skip shell setup (oh-my-zsh, plugins)"
  echo "  --dry-run         Show what would be done without executing"
  echo "  -h, --help        Show this help message"
}

parse_args() {
  for arg in "$@"; do
    case "$arg" in
    --skip-packages) SKIP_PACKAGES=true ;;
    --skip-symlinks) SKIP_SYMLINKS=true ;;
    --skip-shell) SKIP_SHELL=true ;;
    --dry-run) DRY_RUN=true ;;
    -h | --help)
      print_usage
      exit 0
      ;;
    *) warn "Unknown option: $arg" ;;
    esac
  done
}

# Package Installation
install_apt_packages() {
  local packages=(
    zsh
    git
    curl
    wget
    unzip
    ripgrep
    fd-find
    tmux
    build-essential
    python3
    python3-pip
    nodejs
    npm
  )

  log "Updating apt package list..."
  run "sudo apt update -qq"

  log "Installing apt packages..."
  for pkg in "${packages[@]}"; do
    if dpkg -l "$pkg" &>/dev/null; then
      success "$pkg already installed"
    else
      log "Installing $pkg..."
      run "sudo apt install -y $pkg" && success "$pkg installed" || warn "Failed to install $pkg"
    fi
  done
}

install_neovim() {
  if command_exists nvim; then
    success "neovim already installed ($(nvim --version | head -1))"
    return
  fi

  log "Installing neovim..."
  local nvim_url="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz"
  run "curl -fsSL $nvim_url -o /tmp/nvim.tar.gz"
  run "sudo tar -C /usr/local -xzf /tmp/nvim.tar.gz --strip-components=1"
  run "rm /tmp/nvim.tar.gz"
  success "neovim installed"
}

install_fzf() {
  if command_exists fzf; then
    success "fzf already installed"
    return
  fi

  log "Installing fzf..."
  run "git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf"
  run "~/.fzf/install --all --no-update-rc"
  success "fzf installed"
}

install_tmux_plugin_manager() {
  local tpm_dir="$HOME/.tmux/plugins/tpm"
  if [[ -d "$tpm_dir" ]]; then
    success "tmux plugin manager already installed"
    return
  fi

  log "Installing tmux plugin manager (tpm)..."
  run "git clone https://github.com/tmux-plugins/tpm $tpm_dir"
  success "tpm installed"
}

# Shell Setup
install_oh_my_zsh() {
  if [[ -d "$HOME/.oh-my-zsh" ]]; then
    success "oh-my-zsh already installed"
    return
  fi

  log "Installing oh-my-zsh..."
  run 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended'
  success "oh-my-zsh installed"
}

install_zsh_plugins() {
  local zsh_custom="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

  local plugins=(
    "zsh-autosuggestions|https://github.com/zsh-users/zsh-autosuggestions"
    "zsh-syntax-highlighting|https://github.com/zsh-users/zsh-syntax-highlighting"
  )

  for entry in "${plugins[@]}"; do
    local name="${entry%%|*}"
    local url="${entry##*|}"
    local dest="$zsh_custom/plugins/$name"

    if [[ -d "$dest" ]]; then
      success "zsh plugin '$name' already installed"
    else
      log "Installing zsh plugin: $name..."
      run "git clone $url $dest"
      success "zsh plugin '$name' installed"
    fi
  done
}

install_powerlevel10k() {
  local theme_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
  if [[ -d "$theme_dir" ]]; then
    success "powerlevel10k already installed"
    return
  fi

  log "Installing powerlevel10k theme..."
  run "git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $theme_dir"
  success "powerlevel10k installed"
}

setup_zsh_as_default() {
  local zsh_path
  zsh_path="$(command -v zsh)"

  if [[ "$SHELL" == "$zsh_path" ]]; then
    success "zsh is already the default shell"
    return
  fi

  log "Setting zsh as default shell..."
  if ! grep -q "$zsh_path" /etc/shells; then
    run "echo $zsh_path | sudo tee -a /etc/shells"
  fi
  run "chsh -s $zsh_path"
  success "Default shell changed to zsh (takes effect on next login)"
}

# Symlinks
create_symlink() {
  local source="$1"
  local target="$2"

  if [[ ! -e "$source" ]]; then
    warn "Source not found, skipping: $source"
    return
  fi

  if [[ -L "$target" ]]; then
    local current_link
    current_link="$(readlink "$target")"
    if [[ "$current_link" == "$source" ]]; then
      success "Symlink already correct: $target"
      return
    fi
    warn "Replacing existing symlink: $target -> $current_link"
    run "rm $target"
  elif [[ -e "$target" ]]; then
    local backup="${target}.bak.$(date +%Y%m%d_%H%M%S)"
    warn "Backing up existing file: $target -> $backup"
    run "mv $target $backup"
  fi

  run "ln -sf $source $target"
  success "Symlinked: $target -> $source"
}

setup_symlinks() {
  log "Creating symlinks..."

  # nvim config
  create_symlink "$DOTFILES_DIR/nvim" "$CONFIG_DIR/nvim"

  # tmux config
  create_symlink "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"

  # shell aliases
  local aliases_source="$DOTFILES_DIR/shell/aliases.sh"
  local aliases_target="$HOME/.config/shell/aliases.sh"
  if [[ "$DOTFILES_DIR" != "$CONFIG_DIR" ]]; then
    create_symlink "$aliases_source" "$aliases_target"
  fi
}

setup_zshrc() {
  local zshrc="$HOME/.zshrc"

  if [[ -f "$zshrc" ]] && grep -q "DOTFILES_DIR\|aliases.sh" "$zshrc" 2>/dev/null; then
    success ".zshrc already configured"
    return
  fi

  log "Configuring .zshrc..."

  if [[ "$DRY_RUN" == false ]]; then
    cat >>"$zshrc" <<'EOF'

# ── Dotfiles ──────────────────────────────────
if [ -f "$HOME/.config/shell/aliases.sh" ]; then
  source "$HOME/.config/shell/aliases.sh"
fi

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.fzf/bin:$PATH"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
EOF
  else
    echo -e "${YELLOW}[DRY-RUN]${RESET} Would append dotfiles block to $zshrc"
  fi

  success ".zshrc configured"
}

# Main
print_banner() {
  echo -e "${BOLD}${CYAN}"
  echo "╔═══════════════════════════════════════╗"
  echo "║        Dotfiles Installer             ║"
  echo "╚═══════════════════════════════════════╝"
  echo -e "${RESET}"
}

main() {
  parse_args "$@"

  print_banner

  [[ "$DRY_RUN" == true ]] && warn "DRY-RUN mode enabled — no changes will be made\n"

  : >"$LOG_FILE"
  log "Install started at $(date)"
  log "Dotfiles directory: $DOTFILES_DIR"

  if [[ "$SKIP_PACKAGES" == false ]]; then
    step "Installing system packages"
    install_apt_packages
    install_neovim
    install_fzf
    install_tmux_plugin_manager
  else
    warn "Skipping package installation"
  fi

  if [[ "$SKIP_SHELL" == false ]]; then
    step "Setting up shell"
    install_oh_my_zsh
    install_zsh_plugins
    install_powerlevel10k
    setup_zsh_as_default
    setup_zshrc
  else
    warn "Skipping shell setup"
  fi

  if [[ "$SKIP_SYMLINKS" == false ]]; then
    step "Creating symlinks"
    setup_symlinks
  else
    warn "Skipping symlinks"
  fi

  echo ""
  success "Installation complete! Log saved to: $LOG_FILE"
  echo -e "${YELLOW}Note: Restart your terminal (or run 'exec zsh') to apply changes.${RESET}"
}

main "$@"
