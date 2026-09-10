# =========================================================================== [Installation] ===== #

# Install figlet
if ! command -v figlet >/dev/null 2>&1; then
  if [[ "$OS_TYPE" == "mac" ]]; then
    brew install figlet
  elif [[ "$OS_TYPE" == "stm" ]]; then
    nix-env -iA nixpkgs.figlet
  elif [[ "$OS_TYPE" == "win" ]]; then
    sudo apt-get update
    sudo apt-get install -y figlet
  fi
fi

# Install lolcat
if ! command -v lolcat >/dev/null 2>&1; then
  if [[ "$OS_TYPE" == "mac" ]]; then
    brew install lolcat
  elif [[ "$OS_TYPE" == "stm" ]]; then
    nix-env -iA nixpkgs.lolcat
  elif [[ "$OS_TYPE" == "win" ]]; then
    sudo apt-get update
    sudo apt-get install -y lolcat
  fi
fi

# Install gitmoji
if ! command -v gitmoji >/dev/null 2>&1; then
  if [[ "$OS_TYPE" == "mac" ]]; then
    brew install gitmoji
  elif [[ "$OS_TYPE" == "stm" ]]; then
    nix-env -iA nixpkgs.gitmoji-cli
  elif [[ "$OS_TYPE" == "win" ]] && command -v npm >/dev/null 2>&1; then
    npm install -g gitmoji-cli
  fi
fi
