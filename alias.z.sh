
# ================================================================================== [Alias] ===== #

alias npm="echo 'Do you really want to use NPM instead of Yarn? (Ctrl-C to abort, or press enter to continue)' && read && npm"
alias sudo="echo $PASSWORD | sudo -S "

if [[ "$(uname)" == "Linux" ]]; then
    if [[ -f /etc/os-release && $(grep -i ubuntu /etc/os-release) ]]; then
        if grep -qi microsoft /proc/version 2>/dev/null; then
            alias open="explorer.exe"
            alias copy="clip.exe"
        fi
        code-alias() { [ $# -eq 0 ] && code -r . || code -r "$@"; }
        alias nvim="code-alias"
        alias vim="code-alias"
        alias vi="code-alias"
        alias vs="code-alias"
        alias v="code-alias"
    fi
elif [[ "$(uname)" == "Darwin" ]]; then
    alias copy="pbcopy"
    alias vim="nvim"
    alias vi="nvim"
    alias vs="nvim"
    alias v="nvim"
fi

alias start="start-session"
alias end="end-session"