# ========================================================================== [Configuration] ===== #

NOTES_DIR="$HOME/Documents/Notes"
HISTFILE="$NOTES_DIR/.zsh_history"

function notes() {
  if [[ "$1" == "pull" ]]; then
    (
      cd "$NOTES_DIR"
      git fetch origin
      rm -rf .zsh_history
      git pull origin master
    )
  elif [[ "$1" == "push" ]]; then
    (
      cd "$NOTES_DIR"
      if [[ -n "$(git status --porcelain)" ]]; then
        git add .
        timestamp=$(date "+%Y-%m-%d — %I:%M%p")
        git commit -m ":pencil: $timestamp"
        git push origin master
      else
        echo "No changes to push."
      fi
    )
  else
    echo "Usage: notes {pull|push}"
  fi
}

bos-append notes pull "Pull notes changes" "notes pull"
bos-append notes push "Push notes changes" "notes push"
