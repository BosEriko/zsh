# =========================================================================== [Installation] ===== #
# NOTE: Podman is used on steamOS to avoid root issues with Docker

# Install Podman
if [[ "$OS_TYPE" == "stm" ]]; then
  nix-env -iA nixpkgs.podman nixpkgs.podman-compose
fi
