# =========================================================================== [Installation] ===== #

# Install oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install Antigen
if [[ "$OS_TYPE" == "stm" ]]; then
  [ -f "$HOME/.nix-profile/share/antigen/antigen.zsh" ] || nix-env -iA nixpkgs.antigen
fi

if [[ "$OS_TYPE" == "mac" ]]; then
  [ -f "$(brew --prefix)/share/antigen/antigen.zsh" ] || brew install antigen
fi

if [[ "$OS_TYPE" == "win" ]]; then
  if [ ! -f /usr/share/zsh-antigen/antigen.zsh ]; then
    sudo apt-get update
    sudo apt-get install -y zsh-antigen
  fi
fi
