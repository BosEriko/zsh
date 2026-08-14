# ========================================================================== [Configuration] ===== #

start-codex() {
  tmux new-window -n Codex -c "#{pane_current_path}" "codex .; read -p 'Press Enter to close...'"
}

bos-append programming codex "Start codex" "start-codex"
