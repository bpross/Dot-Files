# dot-files

macOS development environment for Benjamin Ross.

## Quick Start

```bash
git clone git@github.com:bpross/dot-files.git ~/github.com/bpross/dot-files
cd ~/github.com/bpross/dot-files
chmod +x install.sh
./install.sh
```

The install script will:
- Symlink all dotfiles into `~`
- Install Homebrew and all packages from `Brewfile`
- Install Oh My Zsh + Powerlevel10k
- Install Rust (rustup), NVM, and Claude Code
- Copy `.secrets.template` to `~/.secrets` if it doesn't exist

## What's Included

| File/Dir | Target | Purpose |
|----------|--------|---------|
| `.zshrc` | `~/.zshrc` | Zsh config (omz, p10k, Go, NVM, gcloud) |
| `.zshenv` | `~/.zshenv` | Cargo env loader |
| `.zprofile` | `~/.zprofile` | Homebrew init for login shells |
| `.aliases` | `~/.aliases` | Git, Docker, grep aliases |
| `.p10k.zsh` | `~/.p10k.zsh` | Powerlevel10k prompt config |
| `.gitconfig` | `~/.gitconfig` | Git user, SSH redirect, pull rebase |
| `.tmux.conf` | `~/.tmux.conf` | Tmux config (gpakosz fork) |
| `config/nvim/` | `~/.config/nvim/` | AstroNvim config (Go, Docker, Copilot) |
| `claude/settings.json` | `~/.claude/settings.json` | Claude Code permissions + MCP servers |
| `claude/mcp.json` | `~/.claude/mcp.json` | MCP server config |
| `Brewfile` | — | All Homebrew packages and casks |
| `.secrets.template` | `~/.secrets` (copy, not link) | API key template |

## Secrets

Sensitive values (API keys, tokens) live in `~/.secrets`, which is **never committed**.

```bash
cp .secrets.template ~/.secrets
# edit ~/.secrets and fill in your values
```

## Manual Steps After Install

1. **SSH keys** — copy `~/.ssh/` from old machine or generate new keys + add to GitHub
2. **Kubernetes** — copy `~/.kube/config` from old machine
3. **Google Cloud** — `gcloud auth login && gcloud auth application-default login`
4. **GitHub CLI** — `gh auth login`
5. **codebase-memory-mcp** — `git clone git@github.com:bpross/codebase-memory-mcp ~/github.com/bpross/codebase-memory-mcp`
6. **Neovim plugins** — open `nvim`, plugins install automatically via Lazy
7. **Node** — `nvm install 22 && nvm use 22`

## Updating the Brewfile

After installing new packages, update `Brewfile`:

```bash
brew bundle dump --file=~/github.com/bpross/dot-files/Brewfile --force
```
