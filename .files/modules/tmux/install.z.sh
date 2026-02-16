# =========================================================================== [Installation] ===== #

# Install Tmux
if [[ "$OS_TYPE" == "stm" ]]; then
  echo "[Modules — Tmux] Installed Via: https://github.com/boseriko/nix"
fi

# Install Plugin Manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
