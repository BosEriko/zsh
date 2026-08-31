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
      claude_target="$repo_root/CLAUDE.md"

      skills_source="$agents_repo/$relative_repo_path/.agents/skills"
      skills_target="$repo_root/.agents/skills"
      claude_skills_target="$repo_root/.claude/skills"

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

      # ------------------------------------------------------------------- CLAUDE.md

      if [ -L "$claude_target" ]; then
        current_source=$(readlink "$claude_target")

        if [ "$current_source" != "$agents_source" ]; then
          rm "$claude_target"
          ln -s "$agents_source" "$claude_target"
          printf 'Relinked %s -> %s\n' "$claude_target" "$agents_source"
        fi
      elif [ -e "$claude_target" ]; then
        printf 'Skipping %s: a non-symlink file already exists\n' "$claude_target" >&2
      else
        ln -s "$agents_source" "$claude_target"
        printf 'Linked %s -> %s\n' "$claude_target" "$agents_source"
      fi

      # ---------------------------------------------------------------------- Skills

      if [ -d "$skills_source" ]; then
        mkdir -p "$repo_root/.agents"

        if [ -L "$skills_target" ]; then
          current_source=$(readlink "$skills_target")

          if [ "$current_source" != "$skills_source" ]; then
            rm "$skills_target"
            ln -s "$skills_source" "$skills_target"
            printf 'Relinked %s -> %s\n' "$skills_target" "$skills_source"
          fi
        elif [ -e "$skills_target" ]; then
          printf 'Skipping %s: a non-symlink file or directory already exists\n' "$skills_target" >&2
        else
          ln -s "$skills_source" "$skills_target"
          printf 'Linked %s -> %s\n' "$skills_target" "$skills_source"
        fi

        # --------------------------------------------------------------- Claude Skills

        mkdir -p "$repo_root/.claude"

        if [ -L "$claude_skills_target" ]; then
          current_source=$(readlink "$claude_skills_target")

          if [ "$current_source" != "$skills_source" ]; then
            rm "$claude_skills_target"
            ln -s "$skills_source" "$claude_skills_target"
            printf 'Relinked %s -> %s\n' "$claude_skills_target" "$skills_source"
          fi
        elif [ -e "$claude_skills_target" ]; then
          printf 'Skipping %s: a non-symlink file or directory already exists\n' "$claude_skills_target" >&2
        else
          ln -s "$skills_source" "$claude_skills_target"
          printf 'Linked %s -> %s\n' "$claude_skills_target" "$skills_source"
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

        if ! grep -Fqx 'CLAUDE.md' "$exclude_file" 2>/dev/null; then
          printf '%s\n' 'CLAUDE.md' >>"$exclude_file"
          printf 'Ignored CLAUDE.md in %s\n' "$repo_root"
        fi

        if ! grep -Fqx '.agents/skills' "$exclude_file" 2>/dev/null; then
          printf '%s\n' '.agents/skills' >>"$exclude_file"
          printf 'Ignored .agents/skills in %s\n' "$repo_root"
        fi

        if ! grep -Fqx '.claude/skills' "$exclude_file" 2>/dev/null; then
          printf '%s\n' '.claude/skills' >>"$exclude_file"
          printf 'Ignored .claude/skills in %s\n' "$repo_root"
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
description: Template for creating repository-specific agent skills. Do not invoke this skill directly.
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

agent-select() {
  local prompt="$1"
  local default_name="$2"
  local countdown="$3"
  shift 3

  local -a options
  local selected=1 countdown_active=0
  local index key

  options=("$@")

  if [ -n "$default_name" ] && ((countdown > 0)); then
    countdown_active=1
  fi

  while true; do
    printf '\033[2J\033[H'
    echo "$prompt"

    if ((countdown_active)); then
      echo "Starting ${default_name} in ${countdown}s..."
    else
      echo
    fi

    for ((index = 1; index <= ${#options}; index++)); do
      if ((index == selected)); then
        printf '  \033[7m> %s\033[0m\n' "${options[index]}"
      else
        printf '    %s\n' "${options[index]}"
      fi
    done

    key=

    if ((countdown_active)); then
      if ! read -rs -k 1 -t 1 key </dev/tty; then
        ((countdown--))

        if ((countdown == 0)); then
          REPLY="$default_name"
          break
        fi

        continue
      fi
    else
      read -rs -k 1 key </dev/tty || return 1
    fi

    case "$key" in
    k)
      ((selected = selected > 1 ? selected - 1 : ${#options}))
      countdown_active=0
      ;;
    j)
      ((selected = selected < ${#options} ? selected + 1 : 1))
      countdown_active=0
      ;;
    $'\n' | $'\r')
      REPLY="${options[selected]}"
      break
      ;;
    $'\e')
      printf '\033[2J\033[H'
      echo "Cancelled."
      return 1
      ;;
    esac
  done

  printf '\033[2J\033[H'
}

agent-start() {
  local -a agent_names
  local agent_name

  agent_names=(Codex Claude OpenCode)

  agent-select \
    "Select an agent (j/k, Enter; Esc to cancel):" \
    "Codex" \
    5 \
    "${agent_names[@]}" || return 0

  agent_name="$REPLY"

  case "$agent_name" in
  Codex)
    tmux new-window -n Codex -c "#{pane_current_path}" "zsh -ic 'codex resume --last; printf \"Press Enter to close...\"; read -r'"
    ;;
  Claude)
    tmux new-window -n Claude -c "#{pane_current_path}" \
      "zsh -ic '
        project_key=\$(pwd | sed \"s|/|-|g\")

        if [[ -d \"\$HOME/.claude/projects/\$project_key\" ]] &&
          find \"\$HOME/.claude/projects/\$project_key\" -name \"*.jsonl\" -print -quit | grep -q .; then
          claude --continue
        else
          claude
        fi

        printf \"Press Enter to close...\"
        read -r
      '"
    ;;
  OpenCode)
    tmux new-window -n Opencode -c "#{pane_current_path}" "zsh -ic 'opencode -c; printf \"Press Enter to close...\"; read -r'"
    ;;
  esac
}

agent-clear() {
  setopt localoptions RM_STAR_SILENT

  codex_sessions_dir="$HOME/.codex/sessions"

  printf "Press Enter to delete ALL Codex, Claude, and OpenCode sessions (anything else cancels): "
  read -r answer

  if [ -n "$answer" ]; then
    echo "Cancelled."
    return 0
  fi

  # ---------------------------------------------------------------------- Codex

  if [ -d "$codex_sessions_dir" ]; then
    rm -rf -- "$codex_sessions_dir"/*(N)
    echo "All Codex sessions deleted."
  fi

  # --------------------------------------------------------------------- Claude

  if command -v claude >/dev/null 2>&1; then
    claude project purge --all --yes
    echo "All Claude sessions deleted."
  fi

  # ------------------------------------------------------------------- OpenCode

  if command -v opencode >/dev/null 2>&1; then
    opencode session list --format json | jq -r '.[].id' | xargs -I {} opencode session delete {}
    echo "All OpenCode sessions deleted."
  fi
}

agent-sessions() {
  local -a agent_names
  local agent_name

  agent_names=(Codex Claude OpenCode)

  agent-select \
    "Select an agent (j/k, Enter; Esc to cancel):" \
    "" \
    0 \
    "${agent_names[@]}" || return 0

  agent_name="$REPLY"

  case "$agent_name" in
  Codex)
    codex resume --all
    ;;
  Claude)
    claude --resume
    ;;
  OpenCode)
    opencode session list
    ;;
  esac
}

agent-connect() {
  if ! command -v codex >/dev/null 2>&1; then
    echo "Codex is not installed or is not in PATH."
    return 1
  fi

  local -a mcp_names
  local mcp_name

  mcp_names=(atlassian)

  agent-select \
    "Select an MCP server (j/k, Enter; Esc to cancel):" \
    "" \
    0 \
    "${mcp_names[@]}" || return 0

  mcp_name="$REPLY"

  if codex mcp get "$mcp_name" >/dev/null 2>&1; then
    echo "Reconnecting: $mcp_name"
    codex mcp logout "$mcp_name" >/dev/null 2>&1
    codex mcp login "$mcp_name"
    return $?
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
bos-append agent pull "Pull and sync agent changes" "agent-pull"
bos-append agent push "Push agent changes" "agent-push"
bos-append agent sessions "List all Codex sessions" "agent-sessions"
bos-append agent start "Start agent" "agent-start"
bos-append agent sync "Sync agent configuration" "agent-sync"
