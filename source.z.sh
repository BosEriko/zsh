
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

# Source elixir
installs_dir=$HOME/.elixir-install/installs
export PATH=$installs_dir/otp/27.1.2/bin:$PATH
export PATH=$installs_dir/elixir/1.18.2-otp-27/bin:$PATH

# Source ./local/bin
export PATH="$HOME/.local/bin:$PATH"