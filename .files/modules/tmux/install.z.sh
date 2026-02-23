# =========================================================================== [Installation] ===== #

# Install Tmux
if [[ "$OS_TYPE" == "stm" ]]; then
  nix-env -iA nixpkgs.tmux
fi
