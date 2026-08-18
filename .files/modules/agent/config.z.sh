# ========================================================================== [Configuration] ===== #

agent-cd() {
  mkdir -p "$HOME/.config/agents" && cd "$HOME/.config/agents"
}

agent-diff() {
  git -C "$HOME/.config/agents" diff "$@"
}

agent-sync() {
  agents_repo="$HOME/.config/agents"

  find "$agents_repo" -type f -name AGENTS.md -not -path "$agents_repo/.git/*" -print0 |
    while IFS= read -r -d '' source; do
      relative_path=${source#"$agents_repo"/}
      target="$HOME/$relative_path"
      target_dir=${target%/AGENTS.md}

      if [ ! -d "$target_dir" ]; then
        printf 'Skipping %s: target directory does not exist\n' "$relative_path" >&2
        continue
      fi

      if [ -L "$target" ]; then
        current_source=$(readlink "$target")

        if [ "$current_source" != "$source" ]; then
          printf 'Skipping %s: symlink points to %s\n' "$target" "$current_source" >&2
          continue
        fi
      elif [ -e "$target" ]; then
        printf 'Skipping %s: a non-symlink file already exists\n' "$target" >&2
        continue
      else
        ln -s "$source" "$target"
        printf 'Linked %s -> %s\n' "$target" "$source"
      fi

      if git_dir=$(git -C "$target_dir" rev-parse --absolute-git-dir 2>/dev/null); then
        exclude_file="$git_dir/info/exclude"

        mkdir -p "${exclude_file%/exclude}"

        if ! grep -Fqx 'AGENTS.md' "$exclude_file" 2>/dev/null; then
          printf '%s\n' 'AGENTS.md' >>"$exclude_file"
          printf 'Ignored AGENTS.md in %s\n' "$target_dir"
        fi
      else
        printf 'Skipping ignore rule for %s: not inside a Git repository\n' "$target_dir" >&2
      fi
    done
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

  # Get repository folder name
  repo_name=$(basename "$repo_root")

  mkdir -p "$agents_dir"

  if [ -e "$agents_file" ]; then
    echo "AGENTS.md already exists:"
    echo "$agents_file"
  else
    printf '# %s Agent\n' "$repo_name" >"$agents_file"

    echo "Created:"
    echo "$agents_file"

    git -C "$agents_repo" add "$agents_file"
    git -C "$agents_repo" commit -m "add AGENTS.md for $relative_path"
    git -C "$agents_repo" push -u origin main
  fi

  agent-sync
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

agent-pull() {
  agents_repo="$HOME/.config/agents"

  git -C "$agents_repo" pull --ff-only || return 1
  agent-sync
}

agent-start() {
  tmux new-window -n Codex -c "#{pane_current_path}" "codex; read -p 'Press Enter to close...'"
}

bos-append agent cd "Go to AGENTS.md repo" "agent-cd"
bos-append agent create "Create AGENTS.md" "agent-create"
bos-append agent diff "Show AGENTS.md changes" "agent-diff"
bos-append agent pull "Pull and sync AGENTS.md changes" "agent-pull"
bos-append agent push "Push AGENTS.md changes" "agent-push"
bos-append agent start "Start agent" "agent-start"
bos-append agent sync "Sync AGENTS.md files" "agent-sync"
