# ========================================================================== [Configuration] ===== #

GIT_HELP_MESSAGE="

    This is a helper showing all your Git custom commands.


    Usage: g [option] [parameter]

${B_GREEN}
    Options:                    Description:
${RESET}

    a, add                      Interactively add files
    b                           Alias for branch
    bd, branch-delete           Delete a branch locally and remotely
    bnc, branch-name-copy       Copy the current branch name to clipboard
    cl, clone                   Clone a repository, choosing which SSH key to use
    cmc, commit-message-copy    Copy the latest commit message to clipboard
    c                           Alias for commit
    cp                          Alias for cherry-pick
    co                          Alias for checkout
    cr, create                  Create a repo on GitHub, GitLab and Bitbucket
    d                           Alias for diff
    dt                          Alias for difftool
    e, emoji                    Show the list of Gitmojis
    g, go                       Instantly add, commit and push
    graph                       Show graph of branches
    h, help                     Show the list of custom Git commands
    lg                          Show log (Changes on all commits)
    lol                         Show log (Single line presentation)
    ls                          Alias for ls-files
    pl                          Alias for pull
    ps                          Alias for push
    pa, push-automatic          Push to the current branch automatically
    r, rework                   Stash and clean the extra files
    re                          Alias for reset
    rl                          List versions
    s                           Alias for status
    sc, sync                    Sync all remote repositories
    so, set-origin              Set the origin path
    st                          Alias for stash
    t, tag                      Tag and push
    w, wtf                      Commit with an automated message

"
g() {
  if [ "$1" = "h" ] || [ "$1" = "help" ]; then
    git-help
  elif [ "$1" = "a" ] || [ "$1" = "add" ]; then
    git-add
  elif [ "$1" = "r" ] || [ "$1" = "rework" ]; then
    git-rework
  elif [ "$1" = "g" ] || [ "$1" = "go" ]; then
    git-go $2
  elif [ "$1" = "w" ] || [ "$1" = "wtf" ]; then
    git-wtf
  elif [ "$1" = "e" ] || [ "$1" = "emoji" ]; then
    git-emoji
  elif [ "$1" = "bnc" ] || [ "$1" = "branch-name-copy" ]; then
    git-branch-name-copy
  elif [ "$1" = "cl" ] || [ "$1" = "clone" ]; then
    git-clone $2
  elif [ "$1" = "cr" ] || [ "$1" = "create" ]; then
    git-create $2
  elif [ "$1" = "pa" ] || [ "$1" = "push-automatic" ]; then
    git-push-automatic
  elif [ "$1" = "cmc" ] || [ "$1" = "commit-message-copy" ]; then
    git-commit-message-copy
  elif [ "$1" = "bd" ] || [ "$1" = "branch-delete" ]; then
    git-branch-delete $2
  elif [ "$1" = "so" ] || [ "$1" = "set-origin" ]; then
    git-set-origin
  elif [ "$1" = "sc" ] || [ "$1" = "sync" ]; then
    git-sync $2
  elif [ "$1" = "t" ] || [ "$1" = "tag" ]; then
    git-tag $2
  else
    git $@
  fi
}

# Rework
git-rework() {
  git reset
  git checkout .
  git clean -fd
}

# Help
git-help() {
  (
    cd ~
    figlet 'Save time!' | lolcat && echo -e $GIT_HELP_MESSAGE
  )
}

# Go
git-go() {
  git add .
  if [ -z "$1" ]; then
    git-wtf
  else
    git commit -m "$1"
  fi
  git push -u origin HEAD
}

# WTF
git-wtf() {
  git commit -m "[AUTO] $(curl -s http://whatthecommit.com/index.txt)"
}

# emoji
git-emoji() {
  gitmoji -c
}

# Push Automatically
git-push-automatic() {
  BRANCH_NAME=$(git branch | grep \* | cut -d ' ' -f2 | tr -d '\n')
  git push origin $BRANCH_NAME
}

# Branch Name Copy
git-branch-name-copy() {
  local branch_name=$(git branch --show-current)
  case "$OS_TYPE" in
  mac) printf '%s' "$branch_name" | pbcopy ;;
  win) printf '%s' "$branch_name" | clip.exe ;;
  *) printf '%s' "$branch_name" | xclip -selection clipboard ;;
  esac
  echo "Branch name has been copied."
}

# Clone
git-clone() {
  local repo="$1"

  if [ -z "$repo" ]; then
    echo "Please specify the git slug [e.g.: BosEriko/config]:"
    read repo
  fi

  if [ -z "$repo" ]; then
    echo "No repository specified."
    return 1
  fi

  # Normalize a full URL (git@host:org/repo.git or https://host/org/repo.git) down to org/repo
  case "$repo" in
  git@*:*)
    repo="${repo#*:}"
    ;;
  *://*/*)
    repo="${repo#*://*/}"
    ;;
  esac
  repo="${repo%.git}"

  local -a pubkeys
  pubkeys=("$HOME"/.ssh/id_rsa_*.pub(N))

  local identifier="default"

  if [[ ${#pubkeys[@]} -gt 0 ]]; then
    echo "default  (git@github.com:...)"

    local pub
    for pub in "${pubkeys[@]}"; do
      identifier="${${pub:t}#id_rsa_}"
      identifier="${identifier%.pub}"
      echo "$identifier  (git@github.${identifier}:...)"
    done

    echo "Please specify the identifier to clone with [e.g.: bos, or 'default']:"
    read identifier
    [ -z "$identifier" ] && identifier="default"

    if [ "$identifier" != "default" ] && [ ! -f "$HOME/.ssh/id_rsa_${identifier}.pub" ]; then
      echo "No key found for '$identifier'."
      return 1
    fi
  fi

  local host="github.com"
  [ "$identifier" != "default" ] && host="github.${identifier}"

  git clone "git@${host}:${repo}.git"
}

# Latest Commit Message Copy
git-commit-message-copy() {
  LAST_COMMIT_MESSAGE=$(git log -1 --pretty=%B)
  echo -n "$LAST_COMMIT_MESSAGE" | clip.exe
  echo "Latest commit message has been copied."
}

# Branch Delete
git-branch-delete() {
  if [ -z "$1" ]; then
    echo "Please specify a branch"
  else
    git branch -D "$1"
  fi
}

# Create
git-create() {
  local repo_name="$1"

  if [ -z "$repo_name" ]; then
    echo "Please specify a repo name:"
    read repo_name
  fi

  if [ -z "$repo_name" ]; then
    echo "No repo name specified."
    return 1
  fi

  if command -v gh >/dev/null 2>&1; then
    gh repo create "$repo_name" --public
  else
    echo "gh not installed, skipping GitHub."
  fi

  if command -v glab >/dev/null 2>&1; then
    glab repo create "$repo_name" --public --skipGitInit
  else
    echo "glab not installed, skipping GitLab."
  fi

  if [ -n "$BITBUCKET_USERNAME" ] && [ -n "$BITBUCKET_APP_PASSWORD" ]; then
    local bb_response bb_status bb_body
    bb_response=$(curl -s -w '\n%{http_code}' -u "${BITBUCKET_USERNAME}:${BITBUCKET_APP_PASSWORD}" \
      -X POST -H "Content-Type: application/json" \
      -d '{"scm": "git", "is_private": false}' \
      "https://api.bitbucket.org/2.0/repositories/${BITBUCKET_USERNAME}/${repo_name}")
    bb_status="${bb_response##*$'\n'}"
    bb_body="${bb_response%$'\n'*}"
    if [ "$bb_status" = "200" ]; then
      echo "Bitbucket repo created."
    else
      echo "Bitbucket repo creation failed (HTTP $bb_status): $bb_body"
    fi
  else
    echo "BITBUCKET_USERNAME/BITBUCKET_APP_PASSWORD not set, skipping Bitbucket."
  fi
}

# Set Origin
git-set-origin() {
  echo "Please specify the git slug [e.g.: BosEriko/config]:"
  read git_slug && git remote rm origin
  git remote add origin git@github.com:${git_slug}.git
  git remote add github git@github.com:${git_slug}.git
  git remote add gitlab git@gitlab.com:${git_slug}.git
  git remote add bitbucket git@bitbucket.org:${git_slug}.git
  git remote set-url --add --push origin git@github.com:${git_slug}.git
  git remote set-url --add --push origin git@gitlab.com:${git_slug}.git
  git remote set-url --add --push origin git@bitbucket.org:${git_slug}.git
  git remote -v
}

# Sync
git-sync() {
  if [ -z "$1" ]; then
    echo "Please specify a branch"
  else
    git pull origin $1
    git push origin $1
  fi
}

# Tag
git-tag() {
  if [ -z "$1" ]; then
    echo "Please specify a release name"
  else
    echo "Do you want to tag and push '$1'? (Ctrl-C to abort, or press enter to continue)"
    read
    git tag $1 -a
    git push origin $1
  fi
}

# Interactive Add
git-add() {
  git add -N .
  git add -p
  git status
}
