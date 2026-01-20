
# ================================================================================= [Source] ===== #

# Source fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Source fnm
FNM_PATH="$HOME/.fnm"
if [ -d "$FNM_PATH" ]; then
    export PATH="$FNM_PATH:$PATH"
    eval "$(fnm env --use-on-cd)"
fi

# Source Yarn
export PATH="$HOME/.yarn/bin:$PATH"

# Source rbenv
export PATH="$HOME/.rbenv/bin:$PATH" && eval "$(rbenv init -)"

# Source ./local/bin
export PATH="$HOME/.local/bin:$PATH"