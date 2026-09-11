# ========================================================================== [Configuration] ===== #

ssh-copy() {
  case "$OS_TYPE" in
  mac) cat ~/.ssh/id_rsa.pub | pbcopy ;;
  win) cat ~/.ssh/id_rsa.pub | clip.exe ;;
  *) cat ~/.ssh/id_rsa.pub | xclip -selection clipboard ;;
  esac
  echo "SSH Key has been copied to clipboard."
}
bos-append ssh key "Copy Main SSH Key to clipboard" "ssh-copy"
