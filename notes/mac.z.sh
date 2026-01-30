
# ================================================================================== [Notes] ===== #

save-notes() {
  local NOTES_DIR=~/Documents/Notes
  local STATE_FILE="$NOTES_DIR/.last_sync"
  local TODAY="$(date +%Y-%m-%d)"
  local YESTERDAY="$(date -v-1d +%Y-%m-%d)"
  local DAY_OF_WEEK="$(date +%u)"

  if [[ "$DAY_OF_WEEK" -eq 6 || "$DAY_OF_WEEK" -eq 7 || ( -f "$STATE_FILE" && "$(cat "$STATE_FILE")" == "$TODAY" ) ]]; then
    return
  fi

  (
    cd "$NOTES_DIR" || return

    git fetch origin master >/dev/null 2>&1
    if git rev-list --count HEAD..origin/master | grep -qv '^0$'; then
      echo "$TODAY" > "$STATE_FILE"
      echo "${YELLOW}${2}Changes on the cloud detected. Skipping sync today. Please fix manually.${RESET}"
      return
    fi

    echo "${CYAN}${2} Syncing Notes.${RESET}"
    echo "$TODAY" > "$STATE_FILE"
    git add .
    git commit -m ":pencil: $YESTERDAY"
    git push origin master
    echo "${GREEN}${2} Notes has been synced.${RESET}"
  )

  clear
}
save-notes
