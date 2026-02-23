# ========================================================================== [Configuration] ===== #

if [[ "$OS_TYPE" == "stm" ]]; then
  if [ ! "$TMUX" = "" ]; then
    if ! tmux show-environment -g NEOFETCH_DONE >/dev/null 2>&1; then
      neofetch
      tmux set-environment -g NEOFETCH_DONE 1
    fi
  fi
fi
