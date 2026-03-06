# ========================================================================== [Configuration] ===== #

NOTES_DIR="$HOME/Documents/Notes"
HISTFILE="$NOTES_DIR/.zsh_history"

function notes() {
  local cmd="$1"

  (
    cd "$NOTES_DIR" || exit

    local BRANCH=$(git symbolic-ref --short HEAD)

    case "$cmd" in
    pull)
      git fetch origin
      rm -rf .zsh_history
      git pull origin "$BRANCH"
      ;;
    push)
      if [[ -z "$(git status --porcelain)" ]]; then
        echo "No changes to push."
      elif [[ $(git rev-list --count HEAD..origin/"$BRANCH") -gt 0 ]]; then
        echo "There are changes on origin. Please pull it first."
      else
        git add .
        timestamp=$(date "+%Y-%m-%d — %I:%M%p")
        git commit -m ":pencil: $timestamp"
        git push origin "$BRANCH"
      fi
      ;;
    *)
      echo "Usage: notes {pull|push}"
      ;;
    esac
  )
}

bos-append notes pull "Pull notes changes" "notes pull"
bos-append notes push "Push notes changes" "notes push"
