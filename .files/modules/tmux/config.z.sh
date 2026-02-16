# ========================================================================== [Configuration] ===== #

if [ "$TMUX" = "" ]; then
  tmux -u attach-session || tmux -u new -s default
fi
