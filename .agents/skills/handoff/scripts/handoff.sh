#!/bin/sh
set -eu

root="$HOME/Documents/Notes/Handoff"
usage="Usage: handoff.sh path <title> | list [count] | prune [keep]"

project_dir() {
  case "$PWD" in
  "$HOME") echo "$root" ;;
  "$HOME"/*) echo "$root/${PWD#"$HOME"/}" ;;
  *) echo "$root$PWD" ;;
  esac
}

handoffs() {
  dir="${1:-$(project_dir)}"
  [ -d "$dir" ] || return 0
  find "$dir" -maxdepth 1 -type f -name '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]-[0-9][0-9][0-9][0-9]-*.md' |
    sort -r
}

command="${1:-}"
case "$command" in
path)
  title="${2:?$usage}"
  if [ -d "$root" ]; then
    dir="$(project_dir)"
    mkdir -p "$dir"
  else
    dir="${TMPDIR:-/tmp}"
    dir="${dir%/}"
  fi
  echo "$dir/$(date +%Y-%m-%d-%H%M)-$title.md"
  ;;
list)
  handoffs | head -n "${2:-10}"
  ;;
prune)
  [ -d "$root" ] || exit 0
  find "$root" -type d | while IFS= read -r dir; do
    handoffs "$dir" | tail -n "+$((${2:-10} + 1))" | while IFS= read -r file; do
      rm -- "$file"
      echo "$file"
    done
  done
  ;;
*)
  echo "$usage" >&2
  exit 1
  ;;
esac
