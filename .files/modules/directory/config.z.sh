# ========================================================================== [Configuration] ===== #

jf() {
  case "$1" in
  "personal")
    check-and-cd ~/Documents/Codes/Personal
    ;;
  "work")
    check-and-cd ~/Documents/Codes/Work
    ;;
  "notes")
    check-and-cd ~/Documents/Notes
    ;;
  *)
    echo "Jump Folder: personal, work or notes"
    ;;
  esac
}

jc() {
  case "$1" in
  "foot")
    check-and-cd ~/.config/foot
    ;;
  "kmonad")
    check-and-cd ~/.config/kmonad
    ;;
  "steam")
    check-and-cd ~
    ;;
  "sway")
    check-and-cd ~/.config/sway
    ;;
  *)
    echo "Jump Configuration: foot, kmonad, steam or sway"
    ;;
  esac
}

work() {
  case "$1" in
  "bos-eriko-com")
    check-and-cd $(eval echo $BOS_ERIKO_COM_DIRECTORY)
    ;;
  "bos-eriko-plus")
    check-and-cd $(eval echo $BOS_ERIKO_PLUS_DIRECTORY)
    ;;
  "boteriko")
    check-and-cd $(eval echo $BOTERIKO_DIRECTORY)
    ;;
  "overlay")
    check-and-cd $(eval echo $OVERLAY_DIRECTORY)
    ;;
  *)
    echo "Jump Work Folder: bos-eriko-com, bos-eriko-plus, boteriko or overlay"
    ;;
  esac
}

check-and-cd() {
  if [ ! -d "$1" ]; then
    mkdir -p "$1"
  fi
  cd "$1"
}
