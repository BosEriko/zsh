
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
    "bos-eriko-data")
        cd $(eval echo $BOS_ERIKO_DATA_DIRECTORY) && code-alias
        ;;
    "bos-eriko-cms")
        cd $(eval echo $BOS_ERIKO_CMS_DIRECTORY) && code-alias
        ;;
    "bosekko")
        cd $(eval echo $BOSEKKO_DIRECTORY) && code-alias
        ;;
    "purrintables")
        cd $(eval echo $PURRINTABLES_DIRECTORY) && code-alias
        ;;
    "referscout")
        cd $(eval echo $REFERSCOUT_DIRECTORY) && code-alias
        ;;
    *)
        echo "Jump Work Folder: bos-eriko-data, bos-eriko-cms, bosekko, purrintables or referscout"
        ;;
    esac
}

check-and-cd() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
    fi
    cd "$1"
}