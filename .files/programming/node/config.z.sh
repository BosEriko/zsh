# ========================================================================== [Configuration] ===== #

if command -v fnm >/dev/null 2>&1; then
  eval "$(fnm env --shell zsh)"
fi

node-pm-warn() {
  local tool="$1"

  echo "pnpm is preferred over $tool. Use pnpm instead."
  printf "Continue with %s anyway? (Y/n) " "$tool"
  read -r answer

  if [[ "$answer" =~ ^[Nn]$ ]]; then
    echo "Cancelled."
    return 1
  fi
}

if command -v pnpm >/dev/null 2>&1; then
  yarn() {
    node-pm-warn yarn || return 1
    command yarn "$@"
  }

  npm() {
    node-pm-warn npm || return 1
    command npm "$@"
  }
fi
