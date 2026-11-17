#!/bin/sh
set -u

if ! command -v gh >/dev/null 2>&1; then
  if command -v brew >/dev/null 2>&1; then
    brew install gh >/dev/null 2>&1 || { echo "install-failed"; exit 1; }
  else
    echo "no-gh"
    exit 1
  fi
fi

status="$(gh auth status 2>&1)" || { echo "not-logged-in"; exit 1; }

case "$status" in
*"'project'"*) ;;
*) echo "missing-project-scope"; exit 1 ;;
esac

case "$status" in
*"'repo'"*) ;;
*) echo "missing-repo-scope"; exit 1 ;;
esac

echo "ok"
