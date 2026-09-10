# =========================================================================== [Installation] ===== #
# NOTE: Podman is used on steamOS to avoid root issues with Docker

# Install Podman
if [[ "$OS_TYPE" == "stm" ]]; then
  nix-env -iA nixpkgs.podman nixpkgs.podman-compose
fi

if [[ "$OS_TYPE" == "mac" ]]; then
  brew install docker
  brew install docker-compose
  brew install colima
  brew services start colima
fi

if [[ "$OS_TYPE" == "win" ]]; then
  curl -fsSL https://get.docker.com | sh
  sudo usermod -aG docker "$USER"
fi
