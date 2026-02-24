# ========================================================================== [Configuration] ===== #

if [[ ! "$PATH" == */home/deck/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/deck/.fzf/bin"
fi

source <(fzf --zsh)
