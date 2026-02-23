# =========================================================================== [Installation] ===== #

# Install Tmux
if [[ "$OS_TYPE" == "stm" ]]; then
  nix-env -iA nixpkgs.tmux
fi

# Install Plugin Manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
