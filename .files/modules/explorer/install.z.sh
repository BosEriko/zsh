# =========================================================================== [Installation] ===== #

# Install yazi dependencies
if [[ "$OS_TYPE" == "stm" ]]; then
  nix-env -iA nixpkgs.yazi
  nix-env -iA nixpkgs.ffmpeg
fi
