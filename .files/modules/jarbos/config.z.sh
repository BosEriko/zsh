# ========================================================================== [Configuration] ===== #

jarbos-start() {
  local lock_dir="$HOME/.jarbos.lock"

  pgrep -f "target/debug/jarbos" >/dev/null 2>&1 && return 1

  if ! mkdir "$lock_dir" 2>/dev/null; then
    kill -0 "$(cat "$lock_dir/pid" 2>/dev/null)" 2>/dev/null && return 1
    rm -rf "$lock_dir"
    mkdir "$lock_dir" 2>/dev/null || return 1
  fi

  echo $$ >"$lock_dir/pid"

  (
    cd ~/.jarbos || { rm -rf "$lock_dir"; return 1; }
    git pull --ff-only origin main
    [ -d node_modules ] || pnpm install
    pnpm tauri dev &
    echo $! >"$lock_dir/pid"
    wait $!
    rm -rf "$lock_dir"
  ) >"$HOME/.jarbos.log" 2>&1
}
