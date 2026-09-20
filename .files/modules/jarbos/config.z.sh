# ========================================================================== [Configuration] ===== #

jarbos-start() {
  local pid_file="$HOME/.jarbos.pid"

  if [ -f "$pid_file" ] && kill -0 "$(cat "$pid_file")" 2>/dev/null; then
    return 1
  fi

  (
    cd ~/.jarbos || return 1
    git pull --ff-only origin main
    [ -d node_modules ] || pnpm install
    pnpm tauri dev &
    echo $! >"$pid_file"
    wait $!
    rm -f "$pid_file"
  )
}
