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

# Symlink
mkdir -p ~/.codex ~/.config/opencode ~/.claude
ln -sf ~/.config/agents/AGENTS.md ~/.codex/AGENTS.md
ln -sf ~/.config/agents/AGENTS.md ~/.config/opencode/AGENTS.md
ln -sf ~/.config/agents/AGENTS.md ~/.claude/CLAUDE.md
ln -sfn ~/.config/agents/.agents/skills ~/.codex/skills
ln -sfn ~/.config/agents/.agents/skills ~/.config/opencode/skills
ln -sfn ~/.config/agents/.agents/skills ~/.claude/skills

# Install Agent
if [[ "$OS_TYPE" == "mac" ]]; then
  brew install --cask codex
  brew install anomalyco/tap/opencode
  curl -fsSL https://claude.ai/install.sh | bash
fi
