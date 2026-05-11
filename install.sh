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
mkdir -p "$HOME/.claude/hooks"
for hook in "$DOTFILES_DIR"/claude/hooks/*.sh; do
  symlink "$hook" "$HOME/.claude/hooks/$(basename "$hook")"
done

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

# ── Go tools ──────────────────────────────────────────────────────────────────
if command -v go &>/dev/null; then
  info "Installing Go tools..."
  export GOPATH="${GOPATH:-$HOME/go}"
  export GOPRIVATE="github.com/moov-io/*,github.com/moovfinancial/*"

  GO_PUBLIC_TOOLS=(
    "golang.org/x/tools/cmd/callgraph@latest"
    "github.com/go-delve/delve/cmd/dlv@latest"
    "github.com/davidrjenni/reftools/cmd/fillswitch@latest"
    "github.com/onsi/ginkgo/v2/ginkgo@latest"
    "github.com/abice/go-enum@latest"
    "mvdan.cc/gofumpt@latest"
    "golang.org/x/tools/cmd/goimports@latest"
    "github.com/twpayne/go-jsonstruct/v3/cmd/gojsonstruct@latest"
    "github.com/golangci/golangci-lint/v2/cmd/golangci-lint@latest"
    "github.com/segmentio/golines@latest"
    "github.com/fatih/gomodifytags@latest"
    "github.com/abenz1267/gomvp@latest"
    "golang.org/x/tools/cmd/gonew@latest"
    "golang.org/x/tools/gopls@latest"
    "golang.org/x/tools/cmd/gorename@latest"
    "github.com/cweill/gotests/gotests@latest"
    "gotest.tools/gotestsum@latest"
    "golang.org/x/vuln/cmd/govulncheck@latest"
    "github.com/koron/iferr@latest"
    "github.com/josharian/impl@latest"
    "github.com/tmc/json-to-struct@latest"
    "github.com/vektra/mockery/v2@latest"
    "go.uber.org/mock/mockgen@latest"
    "github.com/kyoh86/richgo@latest"
    "github.com/adamdecaf/xmlencoderclose@latest"
    "github.com/DeusData/codebase-memory-mcp/cmd/codebase-memory-mcp@latest"
  )

  GO_PRIVATE_TOOLS=(
    "github.com/moovfinancial/bumper/cmd/bump@latest"
    "github.com/moovfinancial/nullscan@latest"
  )

  for pkg in "${GO_PUBLIC_TOOLS[@]}"; do
    go install "$pkg" && success "go install $pkg" || warn "Failed: go install $pkg"
  done

  for pkg in "${GO_PRIVATE_TOOLS[@]}"; do
    go install "$pkg" && success "go install $pkg" || warn "Skipped (needs SSH/auth): $pkg"
  done
else
  warn "Go not found — skipping Go tools. Re-run after installing Go."
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
