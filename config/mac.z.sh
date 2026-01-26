
# ================================================================================= [Config] ===== #

# Path to your oh-my-zsh installation
export ZSH=$HOME/.oh-my-zsh

# History Configuration
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

# Disable Compfix
ZSH_DISABLE_COMPFIX=true

# Source Oh My ZSH
source $ZSH/oh-my-zsh.sh

# Remove Line Name
PROMPT='%F{blue}$(basename "$(git rev-parse --show-toplevel 2>/dev/null)" 2>/dev/null || echo %~)%f $(git rev-parse --abbrev-ref HEAD 2>/dev/null) %F{yellow}%(!.#.>)%f '

# Load Tmux
if [ "$TMUX" = "" ]; then
  tmux attach-session || tmux new -s default
fi

# Use zed as the editor
export VISUAL=zed
export EDITOR=zed
