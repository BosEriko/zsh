# ========================================================================== [Configuration] ===== #

if [ "$TMUX" = "" ]; then
  tmux attach-session || tmux new -s default
fi
