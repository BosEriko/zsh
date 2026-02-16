# ========================================================================== [Configuration] ===== #

if [ "$TMUX" = "" ]; then
  tmux -u attach-session 2>/dev/null || tmux -u new -s default -c "$HOME"
fi
