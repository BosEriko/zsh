
# ================================================================================= [Source] ===== #

# Source fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Source fnm
FNM_PATH="$HOME/.fnm"
if [ -d "$FNM_PATH" ]; then
    export PATH="$FNM_PATH:$PATH"
    eval "$(fnm env --use-on-cd)"
fi

# Source rbenv
export PATH="$HOME/.rbenv/bin:$PATH" && eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

# Source ./local/bin
export PATH="$HOME/.local/bin:$PATH"