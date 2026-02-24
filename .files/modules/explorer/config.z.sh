# ========================================================================== [Configuration] ===== #

function tree() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  command yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd <"$tmp"
  [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

function tree_widget() {
  tree
  zle reset-prompt
}

zle -N tree_widget
bindkey '^E' tree_widget
