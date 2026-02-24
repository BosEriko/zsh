# =========================================================================== [Installation] ===== #

# Install Docker
if [[ "$OS_TYPE" == "stm" ]]; then
  nix-env -iA nixpkgs.docker nixpkgs.docker-compose
fi
