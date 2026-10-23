export HERDR_CONFIG_PATH="$HOME/.herdr/config.toml"

if [[ -d "$HOME/.local/bin" && ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

herdr-start() {
  if [[ "$HERDR_ENV" == "1" ]]; then
    echo "Already inside Herdr."
    return 0
  fi

  if ! command -v herdr >/dev/null 2>&1; then
    echo "Herdr is not installed."
    return 1
  fi

  if [[ -n "$TMUX" ]]; then
    tmux new-window -n Herdr -c "$PWD" \
      -e "HERDR_CONFIG_PATH=$HERDR_CONFIG_PATH" -e "PATH=$PATH" herdr
  else
    herdr
  fi
}

bos-append herdr start "Start Herdr" "herdr-start"
