# =========================================================================== [Installation] ===== #

# Install Tmux
if ! command -v tmux >/dev/null 2>&1; then
  if [[ "$OS_TYPE" == "mac" ]]; then
    brew install tmux
  elif [[ "$OS_TYPE" == "stm" ]]; then
    nix-env -iA nixpkgs.tmux
  elif [[ "$OS_TYPE" == "win" ]]; then
    sudo apt-get update
    sudo apt-get install -y tmux
  fi
fi
