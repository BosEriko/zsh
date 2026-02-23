# =========================================================================== [Installation] ===== #

# Install lolcat and figlet
if [[ "$OS_TYPE" == "stm" ]]; then
  nix-env -iA nixpkgs.figlet nixpkgs.lolcat
fi
