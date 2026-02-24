# =========================================================================== [Installation] ===== #

# Install Podman
if [[ "$OS_TYPE" == "stm" ]]; then
  nix-env -iA nixpkgs.podman nixpkgs.podman-compose
fi
