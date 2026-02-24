# ========================================================================== [Configuration] ===== #

ssh-copy() {
  cat ~/.ssh/id_rsa.pub | xclip
  echo "SSH Key has been copied to clipboard."
}
