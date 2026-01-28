
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
    echo "${CYAN}${2} Syncing Notes.${RESET}"
    git add .
    git diff --cached --quiet || git commit -m ":pencil: $YESTERDAY"
    git push origin master && echo "$TODAY" > "$STATE_FILE"
    echo "${GREEN}${2} Notes has been synced.${RESET}"
  )

  clear
}
save-notes
