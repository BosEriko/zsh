# ========================================================================== [Configuration] ===== #

agent-cd() {
  mkdir -p "$HOME/.config/agents" && cd "$HOME/.config/agents"
}

agent-diff() {
  git -C "$HOME/.config/agents" diff "$@"
}

agent-link() {
  source_path="$1"
  target_path="$2"

  [ -e "$source_path" ] || return 0

  mkdir -p "${target_path:h}"

  if [ -L "$target_path" ]; then
    current_source=$(readlink "$target_path")

    if [ "$current_source" != "$source_path" ]; then
      printf 'Skipping %s: symlink points to %s\n' "$target_path" "$current_source" >&2
    fi
  elif [ -e "$target_path" ]; then
    printf 'Skipping %s: a non-symlink file or directory already exists\n' "$target_path" >&2
  else
    ln -s "$source_path" "$target_path"
    printf 'Linked %s -> %s\n' "$target_path" "$source_path"
  fi
}

agent-ignore() {
  exclude_file="$1"
  pattern="$2"
  repo_root="$3"

  if ! grep -Fqx "$pattern" "$exclude_file" 2>/dev/null; then
    printf '%s\n' "$pattern" >>"$exclude_file"
    printf 'Ignored %s in %s\n' "$pattern" "$repo_root"
  fi
}

agent-create-dir() {
  dir="$1"

  if [ -d "$dir" ]; then
    echo "Directory already exists:"
    echo "$dir"
  else
    mkdir -p "$dir"
    touch "$dir/.keep"

    echo "Created:"
    echo "$dir"
  fi
}

agent-sync() {
  agents_repo="$HOME/.config/agents"

  find "$agents_repo" -type f -name AGENTS.md -not -path "$agents_repo/.git/*" -print0 |
    while IFS= read -r -d '' agents_source; do
      relative_path=${agents_source#"$agents_repo"/}
      relative_repo_path=${relative_path%/AGENTS.md}

      repo_root="$HOME/$relative_repo_path"

      if [ ! -d "$repo_root" ]; then
        printf 'Skipping %s: target repository does not exist\n' "$relative_repo_path" >&2
        continue
      fi

      # --------------------------------------------------------------------- Links

      agent-link \
        "$agents_repo/$relative_repo_path/AGENTS.md" \
        "$repo_root/AGENTS.md"

      agent-link \
        "$agents_repo/$relative_repo_path/.agents/skills" \
        "$repo_root/.agents/skills"

      agent-link \
        "$agents_repo/$relative_repo_path/.scripts" \
        "$repo_root/.scripts"

      agent-link \
        "$agents_repo/$relative_repo_path/.notes" \
        "$repo_root/.notes"

      # ---------------------------------------------------------------- Git Ignore

      if git_dir=$(git -C "$repo_root" rev-parse --absolute-git-dir 2>/dev/null); then
        exclude_file="$git_dir/info/exclude"

        mkdir -p "${exclude_file:h}"

        agent-ignore "$exclude_file" "AGENTS.md" "$repo_root"
        agent-ignore "$exclude_file" ".agents/skills" "$repo_root"
        agent-ignore "$exclude_file" ".scripts" "$repo_root"
        agent-ignore "$exclude_file" ".notes" "$repo_root"
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

  scripts_dir="$agents_dir/.scripts"
  notes_dir="$agents_dir/.notes"

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

  # --------------------------------------------------------------- Managed Dirs

  agent-create-dir "$scripts_dir"
  agent-create-dir "$notes_dir"

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

agent-free() {
  tmux new-window -n Opencode -c "#{pane_current_path}" "opencode -c; read -p 'Press Enter to close...'"
}

agent-clear() {
  setopt localoptions RM_STAR_SILENT

  codex_sessions_dir="$HOME/.codex/sessions"

  printf "Press Enter to delete ALL Codex and OpenCode sessions (anything else cancels): "
  read -r answer

  if [ -z "$answer" ]; then
    if [ -d "$codex_sessions_dir" ]; then
      rm -rf -- "$codex_sessions_dir"/*(N)
      echo "All Codex sessions deleted."
    fi

    opencode session list --format json | jq -r '.[].id' | xargs -I {} opencode session delete {}
    echo "All OpenCode sessions deleted."
  else
    echo "Cancelled."
  fi
}

agent-sessions() {
  codex resume --all
}

agent-connect() {
  if ! command -v codex >/dev/null 2>&1; then
    echo "Codex is not installed or is not in PATH."
    return 1
  fi

  local -a mcp_names
  local selected=1 key
  local mcp_name

  mcp_names=(atlassian)

  while true; do
    printf '\033[2J\033[H'
    echo "Select an MCP server (↑/↓, Enter; q to cancel):"
    echo

    local index
    for ((index = 1; index <= ${#mcp_names}; index++)); do
      if ((index == selected)); then
        printf '  \033[7m> %s\033[0m\n' "${mcp_names[index]}"
      else
        printf '    %s\n' "${mcp_names[index]}"
      fi
    done

    read -rs -k 1 key || return 0

    case "$key" in
    $'\e')
      read -rs -k 2 key
      case "$key" in
      '[A') ((selected = selected > 1 ? selected - 1 : ${#mcp_names})) ;;
      '[B') ((selected = selected < ${#mcp_names} ? selected + 1 : 1)) ;;
      esac
      ;;
    $'\n' | $'\r')
      mcp_name="${mcp_names[selected]}"
      break
      ;;
    q | Q)
      printf '\033[2J\033[H'
      echo "Cancelled."
      return 0
      ;;
    esac
  done

  printf '\033[2J\033[H'

  if codex mcp get "$mcp_name" >/dev/null 2>&1; then
    echo "Already connected: $mcp_name"
    return 0
  fi

  case "$mcp_name" in
  atlassian)
    codex mcp add atlassian --url https://mcp.atlassian.com/v1/mcp/authv2
    ;;
  *)
    echo "Unknown MCP server: $mcp_name"
    return 1
    ;;
  esac
}

bos-append agent cd "Go to agents repo" "agent-cd"
bos-append agent clear "Clear all agent sessions" "agent-clear"
bos-append agent connect "Connect an MCP server" "agent-connect"
bos-append agent create "Create agent config" "agent-create"
bos-append agent diff "Show agent config changes" "agent-diff"
bos-append agent free "Start free agent" "agent-free"
bos-append agent pull "Pull and sync agent changes" "agent-pull"
bos-append agent push "Push agent changes" "agent-push"
bos-append agent sessions "List all Codex sessions" "agent-sessions"
bos-append agent start "Start agent" "agent-start"
bos-append agent sync "Sync agent configuration" "agent-sync"
