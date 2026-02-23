# =========================================================================== [Installation] ===== #

# Install NeoVim
if [[ "$OS_TYPE" == "stm" ]]; then
  nix-env -iA nixpkgs.neovim nixpkgs.gcc
  rm -rf ~/.config/nvim
  git clone https://github.com/LazyVim/starter ~/.config/nvim
fi
