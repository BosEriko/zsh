# =========================================================================== [Installation] ===== #

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Antigen
if [[ "$OS_TYPE" == "stm" ]]; then
  nix-env -iA nixpkgs.antigen
fi

if [[ "$OS_TYPE" == "mac" ]]; then
  brew install antigen
fi
