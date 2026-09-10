# =========================================================================== [Installation] ===== #

if [[ "$OS_TYPE" == "win" ]]; then
  # Install Fastfetch
  if ! command -v fastfetch >/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y fastfetch
  fi
fi
