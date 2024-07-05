
# ========================================================================== [Start Session] ===== #

auto-pull() {
  (
    cd $1
    git checkout .
    git checkout master && git pull origin master
    echo "${GREEN}${2} Repository has been synced successfully.${RESET}"
  )
}

auto-push() {
  (
    cd $1
    if [[ `git status --porcelain` ]]; then
      echo "${CYAN}${2} Repository has been changed. Pushing.${RESET}"
      git add .
      git commit -m ":pencil: ${2} #$(date +%s)"
      git push origin master
      echo "${GREEN}${2} Repository has been pushed successfully.${RESET}"
    else
      echo "${YELLOW}No changes to the ${2} Repository. Skipping.${RESET}"
    fi
  )
}

start-session() {
  # configuration
  auto-pull ~ "Configuration"
  # Source ZSH
  printf "${B_YELLOW}Do you want to source your ZSH config (y/n)? ${RESET}"
  read answer
  if [ "$answer" != "${answer#[Yy]}" ] ;then
    source ~/.zshrc
    echo "${GREEN}${2}ZSH has been sourced successfully.${RESET}"
  else
    echo "${YELLOW}${2}ZSH has not been sourced.${RESET}"
  fi
}


end-session() {
  # history
  (
    cd ~
    echo "${CYAN}${2} History has been changed. Pushing.${RESET}"
    git add ~/.zsh_history
    git commit -m ":pencil: History #$(date +%s)"
    git push origin master
    echo "${GREEN}${2} History has been pushed successfully.${RESET}"
  )
}