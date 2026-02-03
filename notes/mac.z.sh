
# ================================================================================== [Notes] ===== #

save-notes() {
  local NOTES_DIR=~/Documents/Notes
  local STATE_FILE="$NOTES_DIR/.last_sync"
  local WARNING_FILE="$NOTES_DIR/.sync_warning"
  local TODAY="$(date +%Y-%m-%d)"
  local YESTERDAY="$(date -v-1d +%Y-%m-%d)"
  local DAY_OF_WEEK="$(date +%u)"

  if [[ -f "$WARNING_FILE" ]]; then
    if [[ $(git rev-list --count HEAD..origin/master) -eq 0 ]]; then
      rm -f "$WARNING_FILE"
      return
    fi
    clear && echo "${YELLOW}${2}Changes on the cloud is still not pulled. Please fix manually.${RESET}"
    return
  elif [[ "$DAY_OF_WEEK" -ge 6 || ( -f "$STATE_FILE" && "$(cat "$STATE_FILE")" == "$TODAY" ) ]]; then
    return
  fi

  (
    cd "$NOTES_DIR" || return

    git fetch origin master >/dev/null 2>&1
    if [[ $(git rev-list --count HEAD..origin/master) -ne 0 ]]; then
      echo "1" > "$WARNING_FILE"
      clear && echo "${YELLOW}${2}Changes on the cloud detected. Skipping sync today. Please fix manually.${RESET}"
      return
    fi

    echo "${CYAN}${2} Syncing Notes.${RESET}"
    echo "$TODAY" > "$STATE_FILE"
    rm -f "$WARNING_FILE"
    git add .
    git commit -m ":pencil: $YESTERDAY"
    git push origin master
    clear && echo "${GREEN}${2}Notes has been synced.${RESET}"
  )
}
save-notes
