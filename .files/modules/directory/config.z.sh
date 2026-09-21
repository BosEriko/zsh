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
  if [[ "$OS_TYPE" == "stm" ]]; then
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
  elif [[ "$OS_TYPE" == "mac" ]]; then
    case "$1" in
    "yabai")
      check-and-cd ~/Documents/Codes/Configuration/yabai
      ;;
    "agent")
      check-and-cd ~/.config/agents
      ;;
    *)
      echo "Jump Configuration: yabai or agent"
      ;;
    esac
  fi
}

check-and-cd() {
  if [ ! -d "$1" ]; then
    mkdir -p "$1"
  fi
  cd "$1"
}
