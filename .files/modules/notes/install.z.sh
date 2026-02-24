# =========================================================================== [Installation] ===== #

# Install Obsidian
if [[ "$OS_TYPE" == "stm" ]]; then
  NIXPKGS_ALLOW_UNFREE=1 nix-env -iA nixpkgs.obsidian
  mkdir -p ~/Documents/Notes
  (
    cd ~/Documents/Notes
    git init
    git remote add origin git@github.com:BosEriko/obsidian.git
    git remote add github git@github.com:BosEriko/obsidian.git
    git remote add gitlab git@gitlab.com:BosEriko/obsidian.git
    git remote add bitbucket git@bitbucket.org:BosEriko/obsidian.git
    git remote set-url --add --push origin git@github.com:BosEriko/obsidian.git
    git remote set-url --add --push origin git@gitlab.com:BosEriko/obsidian.git
    git remote set-url --add --push origin git@bitbucket.org:BosEriko/obsidian.git
  )
fi
