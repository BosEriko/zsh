# =========================================================================== [Installation] ===== #

# Install NeoVim
if ! command -v nvim >/dev/null 2>&1; then
  if [[ "$OS_TYPE" == "mac" ]]; then
    brew install neovim
  elif [[ "$OS_TYPE" == "stm" ]]; then
    nix-env -iA nixpkgs.neovim nixpkgs.gcc
  elif [[ "$OS_TYPE" == "win" ]]; then
    sudo apt-get update
    sudo apt-get install -y neovim build-essential
  fi
fi

# Install LazyVim starter
if [ ! -d ~/.config/nvim ]; then
  git clone https://github.com/LazyVim/starter ~/.config/nvim
fi
