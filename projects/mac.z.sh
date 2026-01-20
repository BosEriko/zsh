
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
    "obs")
        cd $OBS_DIRECTORY
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
    *)
        echo "Jump Configuration: obs, zsh, vs or glaze"
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