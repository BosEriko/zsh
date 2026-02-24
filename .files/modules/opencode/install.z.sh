# =========================================================================== [Installation] ===== #

# Install Opencode
if [[ "$OS_TYPE" == "stm" ]]; then
  nix-env -iA nixpkgs.opencode
fi
