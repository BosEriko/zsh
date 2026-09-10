# =========================================================================== [Installation] ===== #

# Install Node.js, Yarn and fnm (https://github.com/Schniz/fnm)
if [[ "$OS_TYPE" == "mac" ]]; then
  brew install node
  brew install yarn
  brew install fnm
fi

if [[ "$OS_TYPE" == "stm" ]]; then
  nix-env -iA nixpkgs.nodejs nixpkgs.yarn nixpkgs.fnm
fi

if [[ "$OS_TYPE" == "win" ]]; then
  sudo apt-get update
  sudo apt-get install -y nodejs npm
  curl -fsSL https://fnm.vercel.app/install | bash -s -- --install-dir "$HOME/.local/bin" --skip-shell
fi

# Disable SSL Verification
if command -v yarn >/dev/null 2>&1; then
  yarn config set "strict-ssl" false
fi

# Avoid running postinstall scripts from packages
if command -v npm >/dev/null 2>&1; then
  npm config set ignore-scripts true
fi
