
# ============================================================================ [Hotfix] ===== #

# This is a Visual Studio Code fix to avoid errors when not in root directory on terminal open
[[ "$PWD" == "$WINDOWS_USER_DIRECTORY" ]] && cd ~