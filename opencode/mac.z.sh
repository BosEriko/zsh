
# =============================================================================== [Opencode] ===== #

function opencode_widget() {
  opencode .
  zle reset-prompt
}

zle -N opencode_widget
bindkey '^Y' opencode_widget
