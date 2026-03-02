# =================================================================================== [Sync] ===== #

sync-zsh() {
  local SYNC_FILE="$HOME/.last_sync"
  local TODAY="$(date +%Y-%m-%d)"
  local BRANCH=$(git symbolic-ref --short HEAD)

  if [[ -f "$SYNC_FILE" && "$(cat "$SYNC_FILE")" != "$TODAY" ]]; then
    git fetch --quiet
    if ! [[ $(git rev-list --count HEAD..origin/"$BRANCH") -eq 0 ]]; then
      echo "There are changes on origin. Do you want to pull? (Y/n)"
      read -r response
      if [[ ! "$response" =~ ^[Nn]$ ]]; then
        echo "Pulling latest changes..."
        git pull origin "$BRANCH"
      else
        echo "Skipping pull."
      fi
    fi
  fi

  echo "$TODAY" >"$SYNC_FILE"
}
[ -n "$TMUX" ] && sync-zsh
