# ========================================================================== [Configuration] ===== #

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
ZSH_DISABLE_COMPFIX=true

if [[ "$OS_TYPE" == "stm" ]]; then
  source $HOME/.nix-profile/share/antigen/antigen.zsh
fi

if [[ "$OS_TYPE" == "mac" ]]; then
  source $(brew --prefix)/share/antigen/antigen.zsh
fi

export ZSH_PLUGINS_ALIAS_TIPS_TEXT="Has alias: "
antigen use oh-my-zsh
antigen bundle djui/alias-tips
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen apply

source $ZSH/oh-my-zsh.sh
