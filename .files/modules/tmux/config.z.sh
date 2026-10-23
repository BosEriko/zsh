# ========================================================================== [Configuration] ===== #

if [[ -z "$TMUX" && "$HERDR_ENV" != "1" ]]; then
  tmux -u attach-session || tmux -u new -s default -c "$HOME"
fi
