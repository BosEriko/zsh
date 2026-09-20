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

  if [ ! -d ~/.jarbos ]; then
    rm -rf "$lock_dir"
    return 1
  fi

  (
    cd ~/.jarbos
    today="$(date +%Y-%m-%d)"

    if [[ -f .last_sync && "$(cat .last_sync)" != "$today" ]]; then
      git fetch --quiet
      if [ "$(git rev-list --count HEAD..origin/main 2>/dev/null)" -gt 0 ]; then
        echo "There are changes on origin. Do you want to pull? (Y/n)"
        read -r response
        if [[ ! "$response" =~ ^[Nn]$ ]]; then
          echo "Pulling latest changes..."
          git pull --ff-only origin main
        else
          echo "Skipping pull."
        fi
      fi
    fi

    echo "$today" >.last_sync
  )

  (
    cd ~/.jarbos || { rm -rf "$lock_dir"; return 1; }
    [ -d node_modules ] || pnpm install
    pnpm tauri dev &
    echo $! >"$lock_dir/pid"
    wait $!
    rm -rf "$lock_dir"
  ) >"$HOME/.jarbos.log" 2>&1 &!
}
