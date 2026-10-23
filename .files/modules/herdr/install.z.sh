if ! command -v herdr >/dev/null 2>&1; then
  if [[ "$OS_TYPE" == "mac" ]]; then
    brew install herdr || return 1
  elif [[ "$OS_TYPE" == "stm" || "$OS_TYPE" == "win" ]]; then
    (set -o pipefail; curl -fsSL https://herdr.dev/install.sh | sh) || return 1
  else
    echo "Herdr installation is not configured for $OS_TYPE."
    return 1
  fi
fi
