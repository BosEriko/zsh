# ========================================================================== [Configuration] ===== #

if [[ "$OS_TYPE" == "stm" ]]; then
  if [ ! "$TMUX" = "" ]; then
    if ! tmux show-environment -g NEOFETCH_DONE >/dev/null 2>&1; then
      neofetch
      echo "Run 'bos -h' to list all custom commands."
      tmux set-environment -g NEOFETCH_DONE 1
    fi
  fi
fi
