
# ================================================================================== [Notes] ===== #

save-notes() {
  local NOTES_DIR=~/Documents/Notes
  local STATE_FILE="$NOTES_DIR/.last_sync"
  local TODAY="$(date +%Y-%m-%d)"
  local YESTERDAY="$(date -v-1d +%Y-%m-%d)"

  if [[ -f "$STATE_FILE" ]] && [[ "$(cat "$STATE_FILE")" == "$TODAY" ]]; then
    return
  fi

  (
    cd "$NOTES_DIR" || return
    echo "${CYAN}${2} Syncing Notes.${RESET}"
    git add .
    git diff --cached --quiet || git commit -m ":pencil: $YESTERDAY Note"
    git push origin master && echo "$TODAY" > "$STATE_FILE"
    echo "${GREEN}${2} Notes has been synced.${RESET}"
  )

  clear
}
save-notes
