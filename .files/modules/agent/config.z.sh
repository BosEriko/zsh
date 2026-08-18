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
    while IFS= read -r -d '' agents_source; do
      relative_path=${agents_source#"$agents_repo"/}
      relative_repo_path=${relative_path%/AGENTS.md}

      repo_root="$HOME/$relative_repo_path"
      agents_target="$repo_root/AGENTS.md"

      skills_source="$agents_repo/$relative_repo_path/.agents/skills"
      skills_target="$repo_root/.agents/skills"

      if [ ! -d "$repo_root" ]; then
        printf 'Skipping %s: target repository does not exist\n' "$relative_repo_path" >&2
        continue
      fi

      # ------------------------------------------------------------------- AGENTS.md

      if [ -L "$agents_target" ]; then
        current_source=$(readlink "$agents_target")

        if [ "$current_source" != "$agents_source" ]; then
          printf 'Skipping %s: symlink points to %s\n' "$agents_target" "$current_source" >&2
          continue
        fi
      elif [ -e "$agents_target" ]; then
        printf 'Skipping %s: a non-symlink file already exists\n' "$agents_target" >&2
        continue
      else
        ln -s "$agents_source" "$agents_target"
        printf 'Linked %s -> %s\n' "$agents_target" "$agents_source"
      fi

      # ---------------------------------------------------------------------- Skills

      if [ -d "$skills_source" ]; then
        mkdir -p "$repo_root/.agents"

        if [ -L "$skills_target" ]; then
          current_source=$(readlink "$skills_target")

          if [ "$current_source" != "$skills_source" ]; then
            printf 'Skipping %s: symlink points to %s\n' "$skills_target" "$current_source" >&2
          fi
        elif [ -e "$skills_target" ]; then
          printf 'Skipping %s: a non-symlink file or directory already exists\n' "$skills_target" >&2
        else
          ln -s "$skills_source" "$skills_target"
          printf 'Linked %s -> %s\n' "$skills_target" "$skills_source"
        fi
      fi

      # ---------------------------------------------------------------- Git Ignore

      if git_dir=$(git -C "$repo_root" rev-parse --absolute-git-dir 2>/dev/null); then
        exclude_file="$git_dir/info/exclude"

        mkdir -p "${exclude_file%/exclude}"

        if ! grep -Fqx 'AGENTS.md' "$exclude_file" 2>/dev/null; then
          printf '%s\n' 'AGENTS.md' >>"$exclude_file"
          printf 'Ignored AGENTS.md in %s\n' "$repo_root"
        fi

        if ! grep -Fqx '.agents/' "$exclude_file" 2>/dev/null; then
          printf '%s\n' '.agents/' >>"$exclude_file"
          printf 'Ignored .agents/ in %s\n' "$repo_root"
        fi
      else
        printf 'Skipping ignore rules for %s: not a Git repository\n' "$repo_root" >&2
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
  skills_dir="$agents_dir/.agents/skills"
  template_skill_dir="$skills_dir/template"
  template_skill_file="$template_skill_dir/SKILL.md"

  repo_name=$(basename "$repo_root")

  mkdir -p "$template_skill_dir"

  # ------------------------------------------------------------------- AGENTS.md

  if [ -e "$agents_file" ]; then
    echo "AGENTS.md already exists:"
    echo "$agents_file"
  else
    printf '# %s Agent\n' "$repo_name" >"$agents_file"

    echo "Created:"
    echo "$agents_file"
  fi

  # ---------------------------------------------------------------- Template Skill

  if [ -e "$template_skill_file" ]; then
    echo "Template skill already exists:"
    echo "$template_skill_file"
  else
    cat >"$template_skill_file" <<'EOF'
---
name: template
description: Template for creating repository-specific Codex skills. Do not invoke this skill directly.
---

# Workflow

1. Define the specific task this skill should handle.
2. Identify the existing repository patterns relevant to the task.
3. Follow those patterns instead of introducing unnecessary abstractions.
4. Perform the implementation.
5. Verify the result using the repository's existing tests, linting, and validation commands.

# Rules

- Keep the skill focused on one workflow.
- Follow existing repository conventions.
- Prefer existing helpers and abstractions.
- Avoid unrelated changes.
- Include verification steps.
EOF

    echo "Created:"
    echo "$template_skill_file"
  fi

  # ------------------------------------------------------------------------- Git

  git -C "$agents_repo" add "$agents_dir"

  if git -C "$agents_repo" diff --cached --quiet; then
    echo "No agent configuration changes to commit."
  else
    git -C "$agents_repo" commit -m "add agent config for $relative_path"
    git -C "$agents_repo" push -u origin main
  fi

  agent-sync
}

agent-push() {
  agents_repo="$HOME/.config/agents"

  git -C "$agents_repo" add -A

  if git -C "$agents_repo" diff --cached --quiet; then
    echo "No agent changes to push."
    return 0
  fi

  git -C "$agents_repo" commit -m "${1:-update agent configuration}"
  git -C "$agents_repo" push -u origin main
}

agent-pull() {
  agents_repo="$HOME/.config/agents"

  git -C "$agents_repo" pull --ff-only || return 1
  agent-sync
}

agent-start() {
  tmux new-window -n Codex -c "#{pane_current_path}" "codex resume --last; read -p 'Press Enter to close...'"
}

agent-clear() {
  sessions_dir="$HOME/.codex/sessions"

  if [ ! -d "$sessions_dir" ]; then
    echo "No Codex sessions directory found."
    return 0
  fi

  printf "Delete ALL Codex sessions? [y/N] "
  read -r answer

  case "$answer" in
  y | Y | yes | YES)
    rm -rf "$sessions_dir"/*
    echo "All Codex sessions deleted."
    ;;
  *)
    echo "Cancelled."
    ;;
  esac
}

agent-sessions() {
  codex resume --all
}

bos-append agent cd "Go to agents repo" "agent-cd"
bos-append agent clear "Clear all agent sessions" "agent-clear"
bos-append agent create "Create agent config" "agent-create"
bos-append agent diff "Show agent config changes" "agent-diff"
bos-append agent pull "Pull and sync agent changes" "agent-pull"
bos-append agent push "Push agent changes" "agent-push"
bos-append agent sessions "List all Codex sessions" "agent-sessions"
bos-append agent start "Start agent" "agent-start"
bos-append agent sync "Sync agent configuration" "agent-sync"
