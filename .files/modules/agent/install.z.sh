# =========================================================================== [Installation] ===== #

# Clone repository
if [ ! -d ~/.config/brains ]; then
  mkdir -p ~/.config
  git clone https://github.com/BosEriko/BRAINS.md.git ~/.config/brains
  (
    cd ~/.config/brains
    git remote rm origin
    git remote add origin git@github.com:BosEriko/BRAINS.md.git
    git remote add github git@github.com:BosEriko/BRAINS.md.git
    git remote add gitlab git@gitlab.com:BosEriko/BRAINS.md.git
    git remote add bitbucket git@bitbucket.org:BosEriko/BRAINS.md.git
    git remote set-url --add --push origin git@github.com:BosEriko/BRAINS.md.git
    git remote set-url --add --push origin git@gitlab.com:BosEriko/BRAINS.md.git
    git remote set-url --add --push origin git@bitbucket.org:BosEriko/BRAINS.md.git
  )
fi

# Symlink (Codex)
mkdir -p ~/.codex
ln -sf ~/.agents/AGENTS.md ~/.codex/AGENTS.md
if [ "$(readlink ~/.codex/skills 2>/dev/null)" != "$HOME/.agents/skills" ]; then
  rm -rf ~/.codex/skills
  ln -sfn ~/.agents/skills ~/.codex/skills
fi

# Symlink (Claude)
mkdir -p ~/.claude
ln -sf ~/.agents/AGENTS.md ~/.claude/CLAUDE.md
if [ "$(readlink ~/.claude/skills 2>/dev/null)" != "$HOME/.agents/skills" ]; then
  rm -rf ~/.claude/skills
  ln -sfn ~/.agents/skills ~/.claude/skills
fi

# Symlink (OpenCode)
mkdir -p ~/.config/opencode
ln -sf ~/.agents/AGENTS.md ~/.config/opencode/AGENTS.md
if [ "$(readlink ~/.config/opencode/skills 2>/dev/null)" != "$HOME/.agents/skills" ]; then
  rm -rf ~/.config/opencode/skills
  ln -sfn ~/.agents/skills ~/.config/opencode/skills
fi

# Install Agent (Claude Code)
if ! command -v claude >/dev/null 2>&1; then
  curl -fsSL https://claude.ai/install.sh | bash
fi

# Install Agent (Codex, OpenCode)
if [[ "$OS_TYPE" == "mac" ]]; then
  command -v codex >/dev/null 2>&1 || brew install --cask codex
  command -v opencode >/dev/null 2>&1 || brew install anomalyco/tap/opencode
fi

if [[ "$OS_TYPE" == "stm" ]]; then
  command -v codex >/dev/null 2>&1 || nix-env -iA nixpkgs.codex
  command -v opencode >/dev/null 2>&1 || nix-env -iA nixpkgs.opencode
fi

if [[ "$OS_TYPE" == "win" ]]; then
  command -v opencode >/dev/null 2>&1 || curl -fsSL https://opencode.ai/install | bash

  if ! command -v codex >/dev/null 2>&1; then
    case "$(uname -m)" in
    x86_64 | amd64) codex_arch="x86_64" ;;
    aarch64 | arm64) codex_arch="aarch64" ;;
    *) codex_arch="" ;;
    esac

    if [[ -n "$codex_arch" ]]; then
      mkdir -p ~/.local/bin
      curl -fsSL -o /tmp/codex.tar.gz \
        "https://github.com/openai/codex/releases/latest/download/codex-${codex_arch}-unknown-linux-musl.tar.gz"
      tar -xzf /tmp/codex.tar.gz -C ~/.local/bin
      mv "$HOME/.local/bin/codex-${codex_arch}-unknown-linux-musl" ~/.local/bin/codex
      chmod +x ~/.local/bin/codex
      rm /tmp/codex.tar.gz
    fi
  fi
fi
