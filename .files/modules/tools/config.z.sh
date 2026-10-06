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
  local radius=40
  local points=96
  local two_pi=6.283185307

  echo "Moving the mouse in a circle around ($cx, $cy). Press Ctrl-C to stop."

  local -a cmds
  local i angle x y
  for ((i = 0; i < points; i++)); do
    angle=$((i * two_pi / points))
    x=$((cx + int(radius * cos(angle))))
    y=$((cy + int(radius * sin(angle))))
    cmds+=("m:$x,$y")
  done

  while true; do
    cliclick -w 25 "${cmds[@]}"
  done
}

bos-append tools afk "Move the mouse in a circle to keep the system active" "tools-afk"
