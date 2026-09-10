# =========================================================================== [Installation] ===== #

# Clone repository
mkdir -p ~/.config
git clone https://github.com/BosEriko/AGENTS.md.git ~/.config/agents
(
  cd ~/.config/agents
  git remote rm origin
  git remote add origin git@github.com:BosEriko/AGENTS.md.git
  git remote add github git@github.com:BosEriko/AGENTS.md.git
  git remote add gitlab git@gitlab.com:BosEriko/AGENTS.md.git
  git remote add bitbucket git@bitbucket.org:BosEriko/AGENTS.md.git
  git remote set-url --add --push origin git@github.com:BosEriko/AGENTS.md.git
  git remote set-url --add --push origin git@gitlab.com:BosEriko/AGENTS.md.git
  git remote set-url --add --push origin git@bitbucket.org:BosEriko/AGENTS.md.git
)

# Symlink (Codex)
mkdir -p ~/.codex
ln -sf ~/.agents/AGENTS.md ~/.codex/AGENTS.md
rm -rf ~/.codex/skills
ln -sfn ~/.agents/skills ~/.codex/skills

# Symlink (Claude)
mkdir -p ~/.claude
ln -sf ~/.agents/AGENTS.md ~/.claude/CLAUDE.md
rm -rf ~/.claude/skills
ln -sfn ~/.agents/skills ~/.claude/skills

# Symlink (OpenCode)
mkdir -p ~/.config/opencode
ln -sf ~/.agents/AGENTS.md ~/.config/opencode/AGENTS.md
rm -rf ~/.config/opencode/skills
ln -sfn ~/.agents/skills ~/.config/opencode/skills

# Install Agent (Claude Code)
curl -fsSL https://claude.ai/install.sh | bash

# Install Agent (Codex, OpenCode)
if [[ "$OS_TYPE" == "mac" ]]; then
  brew install --cask codex
  brew install anomalyco/tap/opencode
fi

if [[ "$OS_TYPE" == "stm" ]]; then
  nix-env -iA nixpkgs.codex nixpkgs.opencode
fi

if [[ "$OS_TYPE" == "win" ]]; then
  curl -fsSL https://opencode.ai/install | bash

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
