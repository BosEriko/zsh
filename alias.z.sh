
# ================================================================================== [Alias] ===== #

alias open="explorer.exe"
alias copy="clip.exe"
alias npm="echo 'Do you really want to use NPM instead of Yarn? (Ctrl-C to abort, or press enter to continue)' && read && npm"
alias sudo="echo $PASSWORD | sudo -S "

code-alias() { [ $# -eq 0 ] && code -r . || code -r "$@"; }
alias nvim="code-alias"
alias vim="code-alias"
alias vi="code-alias"
alias vs="code-alias"
alias v="code-alias"

alias start="start-session"
alias end="end-session"
