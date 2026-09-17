# =========================================================================== [Installation] ===== #

# Install Node.js
if ! command -v node >/dev/null 2>&1; then
  if [[ "$OS_TYPE" == "mac" ]]; then
    brew install node
  elif [[ "$OS_TYPE" == "stm" ]]; then
    nix-env -iA nixpkgs.nodejs
  elif [[ "$OS_TYPE" == "win" ]]; then
    sudo apt-get update
    sudo apt-get install -y nodejs npm
  fi
fi

# Install pnpm
if ! command -v pnpm >/dev/null 2>&1; then
  if [[ "$OS_TYPE" == "mac" ]]; then
    brew install pnpm
  elif [[ "$OS_TYPE" == "stm" ]]; then
    nix-env -iA nixpkgs.pnpm
  elif [[ "$OS_TYPE" == "win" ]] && command -v npm >/dev/null 2>&1; then
    npm install -g pnpm
  fi
fi

# Install fnm (https://github.com/Schniz/fnm)
if ! command -v fnm >/dev/null 2>&1; then
  if [[ "$OS_TYPE" == "mac" ]]; then
    brew install fnm
  elif [[ "$OS_TYPE" == "stm" ]]; then
    nix-env -iA nixpkgs.fnm
  elif [[ "$OS_TYPE" == "win" ]]; then
    curl -fsSL https://fnm.vercel.app/install | bash -s -- --install-dir "$HOME/.local/bin" --skip-shell
  fi
fi

# Disable SSL Verification
if command -v pnpm >/dev/null 2>&1; then
  pnpm config set "strict-ssl" false
fi

# Avoid running postinstall scripts from packages
if command -v npm >/dev/null 2>&1; then
  npm config set ignore-scripts true
fi
