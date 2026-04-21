# =========================================================================== [Installation] ===== #

if [[ "$OS_TYPE" == "mac" ]]; then
  # Install Brew
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Install Neofetch
  brew install neofetch
fi
