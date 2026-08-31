# ================================================================================== [Patch] ===== #

# fnm
FNM_PATH="/opt/homebrew/opt/fnm/bin"
if [ -d "$FNM_PATH" ]; then
  eval "$(fnm env --shell zsh)"
fi

# local bin
PATH="$HOME/.local/bin:$PATH"
