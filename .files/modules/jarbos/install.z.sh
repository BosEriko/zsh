# =========================================================================== [Installation] ===== #

# Clone repository
if [ ! -d ~/.jarbos ]; then
  git clone git@github.com:BosEriko/jarbos.git ~/.jarbos
  (
    cd ~/.jarbos
    git remote rm origin
    git remote add origin git@github.com:BosEriko/jarbos.git
    git remote add github git@github.com:BosEriko/jarbos.git
    git remote add gitlab git@gitlab.com:BosEriko/jarbos.git
    git remote add bitbucket git@bitbucket.org:BosEriko/jarbos.git
    git remote set-url --add --push origin git@github.com:BosEriko/jarbos.git
    git remote set-url --add --push origin git@gitlab.com:BosEriko/jarbos.git
    git remote set-url --add --push origin git@bitbucket.org:BosEriko/jarbos.git
  )
fi
