# =========================================================================== [Installation] ===== #

# Clone repository
mkdir -p ~/.config
git clone https://github.com/BosEriko/AGENTS.md.git ~/.config/agents
(
  cd ~/.config/agents
  git remote add origin git@github.com:BosEriko/AGENTS.md.git
  git remote add github git@github.com:BosEriko/AGENTS.md.git
  git remote add gitlab git@gitlab.com:BosEriko/AGENTS.md.git
  git remote add bitbucket git@bitbucket.org:BosEriko/AGENTS.md.git
  git remote set-url --add --push origin git@github.com:BosEriko/AGENTS.md.git
  git remote set-url --add --push origin git@gitlab.com:BosEriko/AGENTS.md.git
  git remote set-url --add --push origin git@bitbucket.org:BosEriko/AGENTS.md.git
)

# Install Agent
if [[ "$OS_TYPE" == "mac" ]]; then
  brew install --cask codex
fi
