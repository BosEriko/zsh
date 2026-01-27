
# =============================================================================== [Projects] ===== #

jf() {
    case "$1" in
    "personal")
        cd ~/Documents/Codes/Personal
        ;;
    "work")
        cd ~/Documents/Codes/Work
        ;;
    "anime")
        cd ~/Movies/Anime
        ;;
    "movies")
        cd ~/Movies/Movies
        ;;
    "youtube")
        cd ~/Movies/YouTube
        ;;
    *)
        echo "Jump Folder: personal, work, anime, movies or youtube"
        ;;
    esac
}

jc() {
    case "$1" in
    "brave")
        cd ~/Documents/Codes/Configuration/brave
        ;;
    "ghostty")
        cd ~/.config/ghostty
        ;;
    "mac")
        cd ~
        ;;
    "yabai")
        cd ~/Documents/Codes/Configuration/yabai
        ;;
    "zed")
        cd ~/.config/zed
        ;;
    "zsh")
        cd ~/.files/zsh
        ;;
    *)
        echo "Jump Configuration: brave, ghostty, mac, yabai, zed or zsh"
        ;;
    esac
}

work() {
    case "$1" in
    "bos-eriko-com")
        cd $(eval echo $BOS_ERIKO_COM_DIRECTORY) && code-alias
        ;;
    "bos-eriko-plus")
        cd $(eval echo $BOS_ERIKO_PLUS_DIRECTORY) && code-alias
        ;;
    "boteriko")
        cd $(eval echo $BOTERIKO_DIRECTORY) && code-alias
        ;;
    "overlay")
        cd $(eval echo $OVERLAY_DIRECTORY) && code-alias
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
