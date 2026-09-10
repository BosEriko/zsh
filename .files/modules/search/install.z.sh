# =========================================================================== [Installation] ===== #

# Install fzf (https://github.com/junegunn/fzf)
if [[ "$OS_TYPE" == "mac" ]]; then
  brew install fzf
fi

if [[ "$OS_TYPE" == "stm" ]]; then
  nix-env -iA nixpkgs.fzf
fi

if [[ "$OS_TYPE" == "win" ]]; then
  sudo apt-get update
  sudo apt-get install -y fzf
fi
