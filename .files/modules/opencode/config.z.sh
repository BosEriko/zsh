# ========================================================================== [Configuration] ===== #

start-opencode() {
  tmux new-window -n Opencode -c "#{pane_current_path}" "opencode .; read -p 'Press Enter to close...'"
}

bos-append programming opencode "Start opencode" "start-opencode"
