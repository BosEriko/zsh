
# ============================================================================ [End Session] ===== #

# To Use: auto-push <FOLDER_PATH> <FOLDER_NAME>
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
