# ========================================================================== [Configuration] ===== #

OPENCODE_START_PROMPT="
  You are now opencode. Please wait for my first instruction.
"

start-opencode() {
  tmux new-window -n Opencode -c "#{pane_current_path}" "opencode . --prompt '$OPENCODE_START_PROMPT'; read -p 'Press Enter to close...'"
}

bos-append programming opencode "Start opencode" "start-opencode"
