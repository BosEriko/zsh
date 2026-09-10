# =========================================================================== [Installation] ===== #

if [[ "$OS_TYPE" == "mac" ]]; then
  # Install figlet, lolcat and gitmoji
  brew install figlet lolcat gitmoji
fi

if [[ "$OS_TYPE" == "stm" ]]; then
  # Install figlet, lolcat and gitmoji
  nix-env -iA nixpkgs.figlet nixpkgs.lolcat nixpkgs.gitmoji-cli
fi

if [[ "$OS_TYPE" == "win" ]]; then
  # Install figlet and lolcat
  sudo apt-get update
  sudo apt-get install -y figlet lolcat

  # Install gitmoji
  if command -v npm >/dev/null 2>&1; then
    npm install -g gitmoji-cli
  fi
fi
