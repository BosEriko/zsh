# =========================================================================== [Installation] ===== #

if [[ "$OS_TYPE" == "stm" ]]; then
  nix-env -iA nixpkgs.neofetch
fi
