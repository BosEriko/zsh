# =========================================================================== [Installation] ===== #

# Install Node
if [[ "$OS_TYPE" == "mac" ]]; then
  # Install Node.js
  brew install node

  # Install Yarn
  brew install yarn

  # Disable SSL Verification
  yarn config set "strict-ssl" false

  # Install fnm (https://github.com/Schniz/fnm)
  brew install fnm

  # Avoid running postinstall scripts from packages
  npm config set ignore-scripts true
fi
