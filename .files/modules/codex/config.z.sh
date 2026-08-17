# ========================================================================== [Configuration] ===== #

agents-sync() {
  ~/.config/agents/sync-agents.sh
}

agents-create() {
  repo_root=$(git rev-parse --show-toplevel 2>/dev/null) || {
    echo "Not inside a Git repository."
    return 1
  }

  case "$repo_root" in
  "$HOME"/*)
    relative_path=${repo_root#"$HOME"/}
    ;;
  *)
    echo "Repository is not inside \$HOME: $repo_root"
    return 1
    ;;
  esac

  agents_repo="$HOME/.config/agents"
  agents_dir="$agents_repo/$relative_path"
  agents_file="$agents_dir/AGENTS.md"

  mkdir -p "$agents_dir"

  if [ -e "$agents_file" ]; then
    echo "AGENTS.md already exists:"
    echo "$agents_file"
  else
    touch "$agents_file"
    echo "Created:"
    echo "$agents_file"

    git -C "$agents_repo" add "$agents_file"
    git -C "$agents_repo" commit -m "add AGENTS.md for $relative_path"
    git -C "$agents_repo" push
  fi

  agents-sync
}

start-codex() {
  tmux new-window -n Codex -c "#{pane_current_path}" "codex; read -p 'Press Enter to close...'"
}

bos-append programming codex "Start codex" "start-codex"
bos-append programming agents-sync "Sync AGENTS.md files" "agents-sync"
bos-append programming agents-create "Create AGENTS.md" "agents-create"
