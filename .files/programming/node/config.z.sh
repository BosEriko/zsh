# ========================================================================== [Configuration] ===== #

if [[ "$OS_TYPE" == "mac" ]]; then
  FNM_PATH="$HOME/.fnm"
  if [ -d "$FNM_PATH" ]; then
    export PATH="$FNM_PATH:$PATH"
    eval "$(fnm env --use-on-cd)"
  fi
fi
