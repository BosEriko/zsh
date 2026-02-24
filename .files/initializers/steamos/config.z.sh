# ========================================================================== [Configuration] ===== #

if [[ "$OS_TYPE" == "stm" ]]; then
  # Run Neofetch
  if [ ! "$TMUX" = "" ]; then
    if ! tmux show-environment -g NEOFETCH_DONE >/dev/null 2>&1; then
      neofetch
      echo "Run 'bos -h' to list all custom commands."
      tmux set-environment -g NEOFETCH_DONE 1
    fi
  fi

  # Initialize Nix
  if [ -z "${__NIX_ENV_LOADED:-}" ]; then
    if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
      . "$HOME/.nix-profile/etc/profile.d/nix.sh"
    fi

    export NIX_SHELL_PRESERVE_PROMPT=1

    if [[ -n "$IN_NIX_SHELL" ]]; then
      export PS1="${PS1}(nix-shell) "
    fi

    export __NIX_ENV_LOADED=1
  fi
fi
