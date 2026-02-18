# ========================================================================== [Configuration] ===== #

if [[ "$OS_TYPE" == "stm" ]]; then
  if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
    . $HOME/.nix-profile/etc/profile.d/nix.sh
  fi

  export NIX_SHELL_PRESERVE_PROMPT=1
  if [[ -n "$IN_NIX_SHELL" ]]; then
    export PS1="$PS1(nix-shell) "
  fi
fi

bos-append nix \
  short=n \
  long=nix \
  command=switch \
  exec="home-manager switch" \
  desc="Build your nix configuration"

bos-append nix \
  short=n \
  long=nix \
  command=garbage-collect \
  exec="nix-collect-garbage" \
  desc="Remove unused nix paths"
