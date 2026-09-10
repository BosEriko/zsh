# =========================================================================== [Installation] ===== #

if [[ "$OS_TYPE" == "mac" ]]; then
  # Install Brew
  if ! command -v brew >/dev/null 2>&1; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  # Install Fastfetch
  if ! command -v fastfetch >/dev/null 2>&1; then
    brew install fastfetch
  fi
fi
