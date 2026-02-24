# ========================================================================== [Configuration] ===== #

ssh-copy() {
  cat ~/.ssh/id_rsa.pub | xclip -selection clipboard
  echo "SSH Key has been copied to clipboard."
}
bos-append programming ssh-key "Copy Main SSH Key to clipboard" "ssh-copy"
