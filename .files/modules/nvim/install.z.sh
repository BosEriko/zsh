# =========================================================================== [Installation] ===== #

# Install NeoVim
if [[ "$OS_TYPE" == "mac" ]]; then
  brew install neovim
fi

if [[ "$OS_TYPE" == "stm" ]]; then
  nix-env -iA nixpkgs.neovim nixpkgs.gcc
fi

if [[ "$OS_TYPE" == "win" ]]; then
  sudo apt-get update
  sudo apt-get install -y neovim build-essential
fi

# Install LazyVim starter
rm -rf ~/.config/nvim
git clone https://github.com/LazyVim/starter ~/.config/nvim
