
# =================================================================================== [Yazi] ===== #

function tree() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  [ -n "$TMUX" ] && tmux set-option -g status off
  command yazi "$@" --cwd-file="$tmp"
  [ -n "$TMUX" ] && tmux set-option -g status on
  IFS= read -r -d '' cwd < "$tmp"
  [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

function tree_widget() {
  tree
  zle reset-prompt
}

zle -N tree_widget
bindkey '^E' tree_widget
