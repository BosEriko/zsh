
# ================================================================================== [Alias] ===== #

alias copy="pbcopy"
alias npm="echo 'Do you really want to use NPM instead of Yarn? (Ctrl-C to abort, or press enter to continue)' && read && npm"
sudo() { echo "$PASSWORD" | command sudo -S "$@" }

send-to-zed() { if [ $# -eq 0 ]; then zed . --reuse; else zed "$@" --reuse; fi; }
alias code="send-to-zed"
alias nvim="send-to-zed"
alias vim="send-to-zed"
alias vi="send-to-zed"
alias vs="send-to-zed"
alias v="send-to-zed"

alias start="start-session"
alias end="end-session"
