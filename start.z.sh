
# ========================================================================== [Start Session] ===== #

auto-pull() {
  (
    cd $1
    git checkout .
    git checkout master && git pull origin master
    echo "${GREEN}${2} Repository has been synced successfully.${RESET}"
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
