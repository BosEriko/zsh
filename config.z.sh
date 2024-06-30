
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

# Line Name
PROMPT='$ '

# Use nano as the editor
export VISUAL=nano
export EDITOR=nano