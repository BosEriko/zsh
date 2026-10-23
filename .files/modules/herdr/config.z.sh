export HERDR_CONFIG_PATH="$HOME/.herdr/config.toml"

if [[ -d "$HOME/.local/bin" && ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

herdr-run-agent() {
  local agent="$BOS_HERDR_AGENT"
  unset BOS_HERDR_AGENT
  precmd_functions=(${precmd_functions:#herdr-run-agent})
  command "$agent"
}

if [[ "$HERDR_ENV" == "1" && "$BOS_HERDR_AGENT" == (claude|codex|opencode) ]]; then
  typeset -ga precmd_functions
  precmd_functions+=(herdr-run-agent)
fi

herdr-create-tabs() {
  local attempt created workspace tab workspaces candidates panes tabs
  for attempt in {1..100}; do
    if workspaces=$(herdr workspace list 2>/dev/null); then
      break
    fi
    sleep 0.1
  done

  [[ -n "$workspaces" ]] || return 1
  workspace=$(print -r -- "$workspaces" | jq -er --arg cwd "$PWD" \
    '[.result.workspaces[] | select(.tokens.bos_cwd == $cwd)][0].workspace_id // empty') || workspace=""
  if [[ -n "$workspace" ]]; then
    herdr workspace focus "$workspace" >/dev/null
    return $?
  fi

  candidates=$(print -r -- "$workspaces" | jq -er '.result.workspaces | map(.workspace_id) | join("\n")') || return 1
  for workspace in ${(f)candidates}; do
    panes=$(herdr pane list --workspace "$workspace") || return 1
    if ! print -r -- "$panes" | jq -e --arg cwd "$PWD" 'any(.result.panes[]; .cwd == $cwd)' >/dev/null; then
      continue
    fi
    tabs=$(herdr tab list --workspace "$workspace") || return 1
    if print -r -- "$tabs" | jq -e '(["Claude", "Codex", "OpenCode"] - [.result.tabs[].label]) == []' >/dev/null; then
      herdr workspace report-metadata "$workspace" --source bos --token "bos_cwd=$PWD" >/dev/null || return 1
      herdr workspace focus "$workspace" >/dev/null
      return $?
    fi
  done

  created=$(herdr workspace create --cwd "$PWD" --label "${PWD:t}" \
    --env BOS_HERDR_AGENT=claude --focus) || return 1
  workspace=$(print -r -- "$created" | jq -er '.result.workspace.workspace_id') || return 1
  tab=$(print -r -- "$created" | jq -er '.result.tab.tab_id') || return 1
  herdr workspace report-metadata "$workspace" --source bos --token "bos_cwd=$PWD" >/dev/null || return 1
  herdr tab rename "$tab" Claude >/dev/null || return 1
  herdr tab create --workspace "$workspace" --cwd "$PWD" --label Codex \
    --env BOS_HERDR_AGENT=codex --no-focus >/dev/null || return 1
  herdr tab create --workspace "$workspace" --cwd "$PWD" --label OpenCode \
    --env BOS_HERDR_AGENT=opencode --no-focus >/dev/null || return 1
}

herdr-close() {
  local workspaces workspace
  if workspaces=$(herdr workspace list 2>/dev/null); then
    for workspace in ${(f)"$(print -r -- "$workspaces" | jq -r '.result.workspaces[].workspace_id')"}; do
      herdr workspace close "$workspace" >/dev/null 2>&1
    done
  fi
  herdr server stop >/dev/null 2>&1
}

herdr-open() {
  local executable bootstrap result
  for executable in herdr jq claude codex opencode; do
    if ! command -v "$executable" >/dev/null 2>&1; then
      echo "$executable is not installed."
      return 1
    fi
  done

  herdr-close
  herdr-create-tabs &
  bootstrap=$!
  herdr
  result=$?
  wait "$bootstrap" || {
    echo "Could not finish creating the Herdr agent tabs."
    return 1
  }
  return "$result"
}

herdr-start() {
  if [[ "$HERDR_ENV" == "1" ]]; then
    echo "Already inside Herdr."
    return 0
  fi

  if ! command -v herdr >/dev/null 2>&1; then
    echo "Herdr is not installed."
    return 1
  fi

  if [[ -n "$TMUX" ]]; then
    tmux new-window -n Herdr -c "$PWD" \
      -e "HERDR_CONFIG_PATH=$HERDR_CONFIG_PATH" -e "PATH=$PATH" \
      "zsh -c 'bos-append() { :; }; source ~/.files/modules/herdr/config.z.sh; herdr-open'"
  else
    herdr-open
  fi
}

bos-append herdr start "Start Herdr" "herdr-start"
