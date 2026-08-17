# ========================================================================== [Configuration] ===== #

agent-cd() {
  cd "$HOME/.config/agents" || return 1
}

agent-sync() {
  ~/.config/agents/sync-agents.sh
}

agent-create() {
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
    git -C "$agents_repo" push -u origin main
  fi

  agents-sync
}

agent-push() {
  agents_repo="$HOME/.config/agents"

  git -C "$agents_repo" add -A

  if git -C "$agents_repo" diff --cached --quiet; then
    echo "No AGENTS changes to push."
    return 0
  fi

  git -C "$agents_repo" commit -m "${1:-update AGENTS.md files}"
  git -C "$agents_repo" push -u origin main
}

agent-start() {
  tmux new-window -n Codex -c "#{pane_current_path}" "codex; read -p 'Press Enter to close...'"
}

bos-append agent cd "Go to AGENTS repo" "agent-cd"
bos-append agent create "Create AGENTS.md" "agent-create"
bos-append agent push "Push AGENTS.md changes" "agent-push"
bos-append agent start "Start codex" "agent-start"
bos-append agent sync "Sync AGENTS.md files" "agent-sync"
