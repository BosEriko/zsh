
# ================================================================================= [Source] ===== #

# Source fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Source fnm
export PATH=/home/boseriko/.fnm:$PATH && eval "$(fnm env --use-on-cd)"

# Source rbenv
export PATH="$HOME/.rbenv/bin:$PATH" && eval "$(rbenv init -)"