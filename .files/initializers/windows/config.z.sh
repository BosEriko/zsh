# ========================================================================== [Configuration] ===== #

if [[ "$OS_TYPE" == "win" ]]; then
  # Run Fastfetch
  if [ ! "$TMUX" = "" ]; then
    if ! tmux show-environment -g FASTFETCH_DONE >/dev/null 2>&1; then
      fastfetch
      echo "Run 'bos -h' to list all custom commands."
      tmux set-environment -g FASTFETCH_DONE 1
    fi
  fi
fi
