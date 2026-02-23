# ========================================================================== [Configuration] ===== #

if [[ "$OS_TYPE" == "stm" ]]; then
  if [ ! "$TMUX" = "" ] && [ -z "$TMUX_FIRST_RUN" ]; then
    neofetch
    export TMUX_FIRST_RUN=1
  fi
fi
