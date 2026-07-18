# =========================================================================== [Installation] ===== #

if [[ "$OS_TYPE" == "stm" ]]; then
  # Install lolcat and figlet
  nix-env -iA nixpkgs.figlet nixpkgs.lolcat
fi

if [[ "$OS_TYPE" == "mac" ]]; then
  # Install gitmoji
  brew install gitmoji
fi
