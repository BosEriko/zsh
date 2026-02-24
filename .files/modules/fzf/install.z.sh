# =========================================================================== [Installation] ===== #

# Install fzf (https://github.com/junegunn/fzf)
if [[ "$OS_TYPE" == "stm" ]]; then
  nix-env -iA nixpkgs.fzf
fi
