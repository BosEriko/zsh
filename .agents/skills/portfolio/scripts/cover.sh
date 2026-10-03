#!/bin/sh
set -eu

url="${1:?Usage: cover.sh <url> [output]}"
output="${2:-COVER.png}"
case "$output" in
/*) ;;
*) output="$(pwd)/$output" ;;
esac

cache="${XDG_CACHE_HOME:-$HOME/.cache}/portfolio-skill"

find_shell() {
  find "$cache" -type f -name chrome-headless-shell -perm -u+x 2>/dev/null | head -n 1
}

shell="$(find_shell)"
if [ -z "$shell" ]; then
  npx -y @puppeteer/browsers install chrome-headless-shell@stable --path "$cache" >/dev/null
  shell="$(find_shell)"
fi

if [ -z "$shell" ]; then
  echo "Could not install chrome-headless-shell." >&2
  exit 1
fi

rm -f "$output"
"$shell" \
  --screenshot="$output" \
  --window-size=1600,800 \
  --hide-scrollbars \
  --virtual-time-budget=10000 \
  "$url" >/dev/null 2>&1 &
pid=$!

elapsed=0
while kill -0 "$pid" 2>/dev/null && [ "$elapsed" -lt 60 ]; do
  sleep 1
  elapsed=$((elapsed + 1))
done
kill "$pid" 2>/dev/null || true

if [ ! -s "$output" ]; then
  echo "Screenshot failed for $url" >&2
  exit 1
fi

echo "$output"
