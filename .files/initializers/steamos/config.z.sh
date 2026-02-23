# ========================================================================== [Configuration] ===== #

if [[ "$OS_TYPE" == "stm" ]]; then
  if [ ! "$TMUX" = "" ]; then
    neofetch
  fi
fi
