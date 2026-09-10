# =========================================================================== [Installation] ===== #
# NOTE: Podman is used on steamOS to avoid root issues with Docker

# Install Podman
if [[ "$OS_TYPE" == "stm" ]]; then
  command -v podman >/dev/null 2>&1 || nix-env -iA nixpkgs.podman
  command -v podman-compose >/dev/null 2>&1 || nix-env -iA nixpkgs.podman-compose
fi

# Install Docker
if [[ "$OS_TYPE" == "mac" ]]; then
  command -v docker >/dev/null 2>&1 || brew install docker
  command -v docker-compose >/dev/null 2>&1 || brew install docker-compose
  command -v colima >/dev/null 2>&1 || brew install colima
  brew services start colima
fi

if [[ "$OS_TYPE" == "win" ]]; then
  if ! command -v docker >/dev/null 2>&1; then
    curl -fsSL https://get.docker.com | sh
    sudo usermod -aG docker "$USER"
  fi
fi
