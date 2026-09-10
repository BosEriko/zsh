# =========================================================================== [Installation] ===== #

# Install Tmux
if [[ "$OS_TYPE" == "mac" ]]; then
  brew install tmux
fi

if [[ "$OS_TYPE" == "stm" ]]; then
  nix-env -iA nixpkgs.tmux
fi

if [[ "$OS_TYPE" == "win" ]]; then
  sudo apt-get update
  sudo apt-get install -y tmux
fi
