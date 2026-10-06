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

  if ! command -v jq >/dev/null 2>&1; then
    echo "jq is required. Install it first."
    return 1
  fi

  zmodload zsh/mathfunc

  local resolution
  resolution=$(system_profiler SPDisplaysDataType -json 2>/dev/null | jq -r '[.SPDisplaysDataType[].spdisplays_ndrvs[]? | select(.spdisplays_main == "spdisplays_yes")._spdisplays_resolution][0]')
  local -a dims=(${(s: :)resolution})
  local cx=$((dims[1] / 2))
  local cy=$((dims[3] / 2))
  local radius=150

  echo "Moving the mouse in a circle around ($cx, $cy). Press Ctrl-C to stop."

  local angle=0
  local step=0.1
  local two_pi=6.283185307
  while true; do
    local x=$((cx + int(radius * cos(angle))))
    local y=$((cy + int(radius * sin(angle))))
    cliclick m:$x,$y
    angle=$((fmod(angle + step, two_pi)))
    sleep 0.05
  done
}

bos-append tools afk "Move the mouse in a circle to keep the system active" "tools-afk"
