# ========================================================================== [Configuration] ===== #

AGENTS_REPO="$HOME/.config/agents"

# ----------------------------------------------------------------------------- Helpers

agent-link() {
  local source="$1"
  local target="$2"

  if [ -L "$target" ]; then
    local current_source
    current_source=$(readlink "$target")

    if [ "$current_source" != "$source" ]; then
      rm "$target"
      ln -s "$source" "$target"
      printf 'Relinked %s -> %s\n' "$target" "$source"
    fi
  elif [ -e "$target" ]; then
    printf 'Skipping %s: non-symlink already exists\n' "$target" >&2
    return 1
  else
    mkdir -p "${target:h}"
    ln -s "$source" "$target"
    printf 'Linked %s -> %s\n' "$target" "$source"
  fi
}

agent-ignore() {
  local exclude_file="$1"
  local path="$2"

  if ! grep -Fqx "$path" "$exclude_file" 2>/dev/null; then
    printf '%s\n' "$path" >>"$exclude_file"
    printf 'Ignored %s\n' "$path"
  fi
}

agent-select() {
  local prompt="$1"
  shift

  local -a items=("$@")
  local selected=1 key index

  while true; do
    printf '\033[2J\033[H'
    echo "$prompt"
    echo

    for ((index = 1; index <= ${#items}; index++)); do
      if ((index == selected)); then
        printf '  \033[7m> %s\033[0m\n' "${items[index]}"
      else
        printf '    %s\n' "${items[index]}"
      fi
    done

    read -rs -k 1 key </dev/tty || return 1

    case "$key" in
    k)
      ((selected = selected > 1 ? selected - 1 : ${#items}))
      ;;
    j)
      ((selected = selected < ${#items} ? selected + 1 : 1))
      ;;
    $'\n' | $'\r')
      REPLY="${items[selected]}"
      return 0
      ;;
    q | Q)
      printf '\033[2J\033[H'
      echo "Cancelled."
      return 1
      ;;
    esac
  done
}

agent-tmux() {
  local name="$1"
  local command="$2"

  tmux new-window \
    -n "$name" \
    -c "#{pane_current_path}" \
    "$command; printf 'Press Enter to close...'; read -r"
}

# --------------------------------------------------------------------------------- cd

agent-cd() {
  mkdir -p "$AGENTS_REPO" && cd "$AGENTS_REPO"
}

# ------------------------------------------------------------------------------- diff

agent-diff() {
  git -C "$AGENTS_REPO" diff "$@"
}

# ------------------------------------------------------------------------------- sync

agent-sync() {
  find "$AGENTS_REPO" \
    -type f \
    -name AGENTS.md \
    -not -path "$AGENTS_REPO/.git/*" \
    -print0 |
    while IFS= read -r -d '' agents_source; do
      local relative_path
      local relative_repo_path
      local repo_root
      local skills_source

      relative_path=${agents_source#"$AGENTS_REPO"/}
      relative_repo_path=${relative_path%/AGENTS.md}

      repo_root="$HOME/$relative_repo_path"
      skills_source="$AGENTS_REPO/$relative_repo_path/.agents/skills"

      if [ ! -d "$repo_root" ]; then
        printf 'Skipping %s: target repository does not exist\n' \
          "$relative_repo_path" >&2
        continue
      fi

      # ---------------------------------------------------------------- Instructions

      if ! agent-link "$agents_source" "$repo_root/AGENTS.md"; then
        continue
      fi

      agent-link "$agents_source" "$repo_root/CLAUDE.md"

      # ---------------------------------------------------------------------- Skills

      if [ -d "$skills_source" ]; then
        agent-link "$skills_source" "$repo_root/.agents/skills"
        agent-link "$skills_source" "$repo_root/.claude/skills"
      fi

      # ------------------------------------------------------------------ Git Ignore

      local git_dir
      local exclude_file

      if git_dir=$(git -C "$repo_root" rev-parse --absolute-git-dir 2>/dev/null); then
        exclude_file="$git_dir/info/exclude"

        mkdir -p "${exclude_file:h}"

        agent-ignore "$exclude_file" "AGENTS.md"
        agent-ignore "$exclude_file" "CLAUDE.md"
        agent-ignore "$exclude_file" ".agents/skills"
        agent-ignore "$exclude_file" ".claude/skills"
      else
        printf 'Skipping ignore rules for %s: not a Git repository\n' \
          "$repo_root" >&2
      fi
    done
}

# ----------------------------------------------------------------------------- create

agent-create() {
  local repo_root
  local relative_path
  local agents_dir
  local agents_file
  local template_skill_file
  local repo_name

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

  agents_dir="$AGENTS_REPO/$relative_path"
  agents_file="$agents_dir/AGENTS.md"
  template_skill_file="$agents_dir/.agents/skills/template/SKILL.md"

  repo_name=$(basename "$repo_root")

  mkdir -p "${template_skill_file:h}"

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

  git -C "$AGENTS_REPO" add "$agents_dir"

  if git -C "$AGENTS_REPO" diff --cached --quiet; then
    echo "No agent configuration changes to commit."
  else
    git -C "$AGENTS_REPO" commit \
      -m "add agent config for $relative_path"

    git -C "$AGENTS_REPO" push -u origin main
  fi

  agent-sync
}

# ------------------------------------------------------------------------------- push

agent-push() {
  git -C "$AGENTS_REPO" add -A

  if git -C "$AGENTS_REPO" diff --cached --quiet; then
    echo "No agent changes to push."
    return 0
  fi

  git -C "$AGENTS_REPO" commit \
    -m "${1:-update agent configuration}"

  git -C "$AGENTS_REPO" push -u origin main
}

# ------------------------------------------------------------------------------- pull

agent-pull() {
  git -C "$AGENTS_REPO" pull --ff-only || return 1
  agent-sync
}

# ------------------------------------------------------------------------------ start

agent-start() {
  agent-select \
    "Select an agent (j/k, Enter; q to cancel):" \
    Codex Claude OpenCode || return

  printf '\033[2J\033[H'

  case "$REPLY" in
  Codex)
    agent-tmux Codex "codex resume --last"
    ;;
  Claude)
    agent-tmux Claude "claude --continue"
    ;;
  OpenCode)
    agent-tmux OpenCode "opencode -c"
    ;;
  esac
}

# ------------------------------------------------------------------------------ clear

agent-clear() {
  setopt localoptions RM_STAR_SILENT

  printf \
    "Press Enter to delete ALL Codex, Claude, and OpenCode sessions (anything else cancels): "

  read -r answer

  if [ -n "$answer" ]; then
    echo "Cancelled."
    return 0
  fi

  # Codex
  if [ -d "$HOME/.codex/sessions" ]; then
    rm -rf -- "$HOME/.codex/sessions"/*(N)
    echo "All Codex sessions deleted."
  fi

  # Claude
  if command -v claude >/dev/null 2>&1; then
    claude project purge --all --yes
    echo "All Claude sessions deleted."
  fi

  # OpenCode
  if command -v opencode >/dev/null 2>&1; then
    opencode session list --format json |
      jq -r '.[].id' |
      xargs -I {} opencode session delete {}

    echo "All OpenCode sessions deleted."
  fi
}

# --------------------------------------------------------------------------- sessions

agent-sessions() {
  agent-select \
    "Select an agent (j/k, Enter; q to cancel):" \
    Codex Claude OpenCode || return

  printf '\033[2J\033[H'

  case "$REPLY" in
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

# ----------------------------------------------------------------------------- connect

agent-connect() {
  if ! command -v codex >/dev/null 2>&1; then
    echo "Codex is not installed or is not in PATH."
    return 1
  fi

  agent-select \
    "Select an MCP server (j/k, Enter; q to cancel):" \
    atlassian || return

  local mcp_name="$REPLY"

  printf '\033[2J\033[H'

  if codex mcp get "$mcp_name" >/dev/null 2>&1; then
    echo "Reconnecting: $mcp_name"

    codex mcp logout "$mcp_name" >/dev/null 2>&1
    codex mcp login "$mcp_name"

    return $?
  fi

  case "$mcp_name" in
  atlassian)
    codex mcp add \
      atlassian \
      --url https://mcp.atlassian.com/v1/mcp/authv2
    ;;
  *)
    echo "Unknown MCP server: $mcp_name"
    return 1
    ;;
  esac
}

# ================================================================================ CLI

bos-append agent cd "Go to agents repo" "agent-cd"
bos-append agent clear "Clear all agent sessions" "agent-clear"
bos-append agent connect "Connect an MCP server" "agent-connect"
bos-append agent create "Create agent config" "agent-create"
bos-append agent diff "Show agent config changes" "agent-diff"
bos-append agent pull "Pull and sync agent changes" "agent-pull"
bos-append agent push "Push agent changes" "agent-push"
bos-append agent sessions "Browse agent sessions" "agent-sessions"
bos-append agent start "Start agent" "agent-start"
bos-append agent sync "Sync agent configuration" "agent-sync"
