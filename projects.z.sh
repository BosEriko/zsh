
# =============================================================================== [Projects] ===== #

jt() {
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
    "music")
        cd $STORAGE/Music
        ;;
    "youtube")
        cd $STORAGE/YouTube
        ;;
    "password")
        cd $STORAGE/Password
        ;;
    "obsidian")
        cd $STORAGE/Obsidian
        ;;
    *)
        echo "Jump to: personal, work, anime, movies, music, youtube, password or obsidian"
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
        echo "Jump to: obs, zsh, vs or glaze"
        ;;
    esac
}