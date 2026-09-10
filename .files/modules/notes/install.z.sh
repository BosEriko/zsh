# =========================================================================== [Installation] ===== #

# Clone repository
mkdir -p ~/Documents
git clone https://github.com/BosEriko/obsidian.git ~/Documents/Notes
(
  cd ~/Documents/Notes
  git remote rm origin
  git remote add origin git@github.com:BosEriko/obsidian.git
  git remote add github git@github.com:BosEriko/obsidian.git
  git remote add gitlab git@gitlab.com:BosEriko/obsidian.git
  git remote add bitbucket git@bitbucket.org:BosEriko/obsidian.git
  git remote set-url --add --push origin git@github.com:BosEriko/obsidian.git
  git remote set-url --add --push origin git@gitlab.com:BosEriko/obsidian.git
  git remote set-url --add --push origin git@bitbucket.org:BosEriko/obsidian.git
)

# Install Obsidian
if [[ "$OS_TYPE" == "mac" ]]; then
  brew install --cask obsidian
fi

if [[ "$OS_TYPE" == "stm" ]]; then
  NIXPKGS_ALLOW_UNFREE=1 nix-env -iA nixpkgs.obsidian
fi

if [[ "$OS_TYPE" == "win" ]]; then
  if command -v winget.exe >/dev/null 2>&1; then
    winget.exe install -e --id Obsidian.Obsidian
  fi
fi
