# ========================================================================== [Configuration] ===== #

if [[ "$OS_TYPE" == "mac" ]]; then
  FNM_PATH="/opt/homebrew/opt/fnm/bin"
  if [ -d "$FNM_PATH" ]; then
    eval "$(fnm env --shell zsh)"
  fi
fi
