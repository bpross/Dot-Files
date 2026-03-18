#!/usr/bin/env bash
# install.sh — symlink dotfiles and set up a new macOS dev machine
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

info()    { echo "[INFO]  $*"; }
success() { echo "[OK]    $*"; }
warn()    { echo "[WARN]  $*"; }

symlink() {
  local src="$1"
  local dst="$2"
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    warn "Backing up existing $dst → ${dst}.bak"
    mv "$dst" "${dst}.bak"
  fi
  ln -sf "$src" "$dst"
  success "Linked $dst → $src"
}

# ── Shell ─────────────────────────────────────────────────────────────────────
info "Linking shell config..."
symlink "$DOTFILES_DIR/.zshrc"    "$HOME/.zshrc"
symlink "$DOTFILES_DIR/.zshenv"   "$HOME/.zshenv"
symlink "$DOTFILES_DIR/.zprofile" "$HOME/.zprofile"
symlink "$DOTFILES_DIR/.aliases"  "$HOME/.aliases"
symlink "$DOTFILES_DIR/.p10k.zsh" "$HOME/.p10k.zsh"

# ── Git ───────────────────────────────────────────────────────────────────────
info "Linking git config..."
symlink "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"

# ── Tmux ─────────────────────────────────────────────────────────────────────
info "Linking tmux config..."
symlink "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"

# ── Neovim ───────────────────────────────────────────────────────────────────
info "Linking Neovim config..."
mkdir -p "$HOME/.config"
symlink "$DOTFILES_DIR/config/nvim" "$HOME/.config/nvim"

# ── Claude Code ───────────────────────────────────────────────────────────────
info "Linking Claude Code config..."
mkdir -p "$HOME/.claude"
symlink "$DOTFILES_DIR/claude/settings.json" "$HOME/.claude/settings.json"
symlink "$DOTFILES_DIR/claude/mcp.json"      "$HOME/.claude/mcp.json"
symlink "$DOTFILES_DIR/claude/CLAUDE.md"     "$HOME/.claude/CLAUDE.md"
symlink "$DOTFILES_DIR/claude/skills"        "$HOME/.claude/skills"

# ── Secrets ───────────────────────────────────────────────────────────────────
if [ ! -f "$HOME/.secrets" ]; then
  warn "No ~/.secrets found. Copying template — fill in your API keys."
  cp "$DOTFILES_DIR/.secrets.template" "$HOME/.secrets"
else
  info "~/.secrets already exists, skipping."
fi

# ── Homebrew ─────────────────────────────────────────────────────────────────
if ! command -v brew &>/dev/null; then
  info "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [ -f "$DOTFILES_DIR/Brewfile" ]; then
  info "Installing Homebrew packages from Brewfile..."
  brew bundle --file="$DOTFILES_DIR/Brewfile"
fi

# ── Oh My Zsh ─────────────────────────────────────────────────────────────────
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  info "Installing Oh My Zsh..."
  RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  info "Oh My Zsh already installed."
fi

# ── Powerlevel10k ─────────────────────────────────────────────────────────────
P10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
if [ ! -d "$P10K_DIR" ]; then
  info "Installing Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
else
  info "Powerlevel10k already installed."
fi

# ── Rust ─────────────────────────────────────────────────────────────────────
if ! command -v rustup &>/dev/null; then
  info "Installing Rust via rustup..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source "$HOME/.cargo/env"
else
  info "Rust already installed."
fi

# ── NVM ───────────────────────────────────────────────────────────────────────
if [ ! -d "$HOME/.nvm" ]; then
  info "Installing NVM..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
else
  info "NVM already installed."
fi

# ── Google Cloud SDK ──────────────────────────────────────────────────────────
if ! command -v gcloud &>/dev/null; then
  warn "Google Cloud SDK not installed. Download from: https://cloud.google.com/sdk/docs/install"
fi

# ── Claude Code ───────────────────────────────────────────────────────────────
if ! command -v claude &>/dev/null; then
  info "Installing Claude Code..."
  npm install -g @anthropic-ai/claude-code
else
  info "Claude Code already installed."
fi

echo ""
success "Done! Open a new terminal or run: source ~/.zshrc"
echo ""
echo "Manual steps remaining:"
echo "  1. Fill in ~/.secrets with your API keys (see .secrets.template)"
echo "  2. Set up SSH keys: copy ~/.ssh/ from old machine or generate new ones"
echo "  3. Copy ~/.kube/config for Kubernetes access"
echo "  4. Run 'gcloud auth login' to authenticate Google Cloud"
echo "  5. Run 'gh auth login' to authenticate GitHub CLI"
echo "  6. Clone codebase-memory-mcp: git clone git@github.com:bpross/codebase-memory-mcp ~/github.com/bpross/codebase-memory-mcp"
