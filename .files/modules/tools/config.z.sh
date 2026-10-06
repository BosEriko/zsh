# ========================================================================== [Configuration] ===== #

tools-afk() {
  if [[ "$OS_TYPE" != "mac" ]]; then
    echo "This command currently only supports macOS."
    return 1
  fi

  if ! command -v cliclick >/dev/null 2>&1; then
    echo "cliclick is required. Install it first."
    return 1
  fi

  zmodload zsh/mathfunc

  local -a c=(${(s:,:)$(cliclick p)})
  local cx=${c[1]}
  local cy=${c[2]}
  local radius=150

  echo "Moving the mouse in a circle around ($cx, $cy). Press Ctrl-C to stop."

  local angle=0
  while true; do
    local x=$((cx + int(radius * cos(angle))))
    local y=$((cy + int(radius * sin(angle))))
    cliclick m:$x,$y
    angle=$((angle + 0.2))
    sleep 1
  done
}

bos-append tools afk "Move the mouse in a circle to keep the system active" "tools-afk"
