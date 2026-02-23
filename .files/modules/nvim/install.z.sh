# =========================================================================== [Installation] ===== #

# Install NeoVim
if [[ "$OS_TYPE" == "stm" ]]; then
  nix-env -iA nixpkgs.neovim
fi
