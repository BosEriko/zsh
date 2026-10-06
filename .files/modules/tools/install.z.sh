# =========================================================================== [Installation] ===== #

# Install cliclick
if [[ "$OS_TYPE" == "mac" ]]; then
  command -v cliclick >/dev/null 2>&1 || brew install cliclick
fi

# Install jq
if [[ "$OS_TYPE" == "mac" ]]; then
  command -v jq >/dev/null 2>&1 || brew install jq
fi
