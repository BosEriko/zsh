# =================================================================================== [Sync] ===== #

sync-zsh() {
  local WARNING_FILE="$HOME/.last_warning"
  local TODAY="$(date +%Y-%m-%d)"
  local BRANCH=$(git symbolic-ref --short HEAD)

  if [[ -f "$WARNING_FILE" && "$(cat "$WARNING_FILE")" != "$TODAY" ]]; then
    git fetch --quiet
    if ! [[ $(git rev-list --count HEAD..origin/"$BRANCH") -eq 0 ]]; then
      echo "There are changes on origin. Do you want to pull? (Y/n)"
      read -r response
      if [[ ! "$response" =~ ^[Nn]$ ]]; then
        echo "Pulling latest changes..."
        git pull --ff-only
      else
        echo "Skipping pull."
      fi
    fi
  fi

  echo "$TODAY" >"$WARNING_FILE"
}
[ -n "$TMUX" ] && sync-zsh
