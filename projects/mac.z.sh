
# =============================================================================== [Projects] ===== #

jf() {
    case "$1" in
    "personal")
        check-and-cd ~/Documents/Codes/Personal
        ;;
    "work")
        check-and-cd ~/Documents/Codes/Work
        ;;
    *)
        echo "Jump Folder: personal or work"
        ;;
    esac
}

jc() {
    case "$1" in
    "ghostty")
        check-and-cd ~/.config/ghostty
        ;;
    "mac")
        check-and-cd ~
        ;;
    "yabai")
        check-and-cd ~/Documents/Codes/Configuration/yabai
        ;;
    "zed")
        check-and-cd ~/.config/zed
        ;;
    "zen")
        check-and-cd ~/Documents/Codes/Configuration/zen
        ;;
    "zsh")
        check-and-cd ~/.files/zsh
        ;;
    *)
        echo "Jump Configuration: brave, ghostty, mac, yabai, zed, zen or zsh"
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
