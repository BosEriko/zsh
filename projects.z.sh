
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
        cd $STORAGE/Anime
        ;;
    "movies")
        cd $STORAGE/Movies
        ;;
    "youtube")
        cd $STORAGE/YouTube
        ;;
    *)
        echo "Jump Folder: personal, work, anime, movies or youtube"
        ;;
    esac
}

jc() {
    case "$1" in
    "obs")
        cd $OBS_DIRECTORY
        ;;
    "chatty")
        cd $CHATTY_DIRECTORY
        ;;
    "zsh")
        cd ~/.files/zsh
        ;;
    "vs")
        cd $VS_DIRECTORY
        ;;
    "glaze")
        cd $GLAZE_DIRECTORY
        ;;
    "vivaldi")
        check-and-cd $STORAGE/Vivaldi
        ;;
    *)
        echo "Jump Configuration: obs, chatty, zsh, vs, glaze or vivaldi"
        ;;
    esac
}

work() {
    case "$1" in
    "kuru-studio-panel")
        cd $(eval echo $KURU_STUDIO_PANEL_DIRECTORY) && code-alias
        ;;
    "kuru-studio-server")
        cd $(eval echo $KURU_STUDIO_SERVER_DIRECTORY) && code-alias
        ;;
    "kuru-studio-network")
        cd $(eval echo $KURU_STUDIO_NETWORK_DIRECTORY) && code-alias
        ;;
    "purrintables")
        cd $(eval echo $PURRINTABLES_DIRECTORY) && code-alias
        ;;
    "referscout")
        cd $(eval echo $REFERSCOUT_DIRECTORY) && code-alias
        ;;
    "admin-now")
        cd $(eval echo $ADMIN_NOW_DIRECTORY) && code-alias
        ;;
    "admin-now-website")
        cd $(eval echo $ADMIN_NOW_WEBSITE_DIRECTORY) && code-alias
        ;;
    *)
        echo "Jump Work Folder: kuru-studio-panel, kuru-studio-server, kuru-studio-network, purrintables, referscout, admin-now or admin-now-website"
        ;;
    esac
}

check-and-cd() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
    fi
    cd "$1"
}