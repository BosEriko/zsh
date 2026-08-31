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

# Install Agent
if [[ "$OS_TYPE" == "mac" ]]; then
  brew install --cask codex
  curl -fsSL https://claude.ai/install.sh | bash
  brew install anomalyco/tap/opencode
fi
