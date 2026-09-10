# =========================================================================== [Installation] ===== #

# Install fzf (https://github.com/junegunn/fzf)
if ! command -v fzf >/dev/null 2>&1; then
  if [[ "$OS_TYPE" == "mac" ]]; then
    brew install fzf
  elif [[ "$OS_TYPE" == "stm" ]]; then
    nix-env -iA nixpkgs.fzf
  elif [[ "$OS_TYPE" == "win" ]]; then
    sudo apt-get update
    sudo apt-get install -y fzf
  fi
fi
