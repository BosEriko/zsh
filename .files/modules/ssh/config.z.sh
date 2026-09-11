# ========================================================================== [Configuration] ===== #

ssh-copy() {
  case "$OS_TYPE" in
  mac) cat ~/.ssh/id_rsa.pub | pbcopy ;;
  win) cat ~/.ssh/id_rsa.pub | clip.exe ;;
  *) cat ~/.ssh/id_rsa.pub | xclip -selection clipboard ;;
  esac
  echo "SSH Key has been copied to clipboard."
}

ssh-key-generate() {
  echo "Please specify an identifier for this key [e.g.: bos]:"
  read identifier

  if [[ ! "$identifier" =~ ^[a-zA-Z0-9_-]+$ ]]; then
    echo "Invalid identifier. Use only letters, numbers, hyphens and underscores."
    return 1
  fi

  local key_file="$HOME/.ssh/id_rsa_${identifier}"
  local host_alias="github.${identifier}"
  local ssh_config="$HOME/.ssh/config"

  if [ -f "$key_file" ]; then
    echo "A key for '$identifier' already exists at $key_file."
  else
    ssh-keygen -t rsa -b 4096 -C "$identifier" -f "$key_file" -N ""
  fi

  if grep -Fxq "Host $host_alias" "$ssh_config" 2>/dev/null; then
    echo "'$host_alias' is already configured in ~/.ssh/config."
  else
    if [ -s "$ssh_config" ] && [ -n "$(tail -c1 "$ssh_config")" ]; then
      printf '\n' >>"$ssh_config"
    fi
    printf 'Host %s\n  HostName github.com\n  User git\n  IdentityFile %s\n  IdentitiesOnly yes\n' \
      "$host_alias" "$key_file" >>"$ssh_config"
    echo "Added '$host_alias' to ~/.ssh/config."
  fi

  echo "Use git@${host_alias}:org/repo.git to clone using this key."
}

ssh-key-copy() {
  ssh-key-list || return 1

  echo "Please specify the identifier of the key to copy [e.g.: bos]:"
  read identifier

  local key_file="$HOME/.ssh/id_rsa_${identifier}.pub"

  if [ ! -f "$key_file" ]; then
    echo "No key found for '$identifier'. Run 'bos --ssh generate' first."
    return 1
  fi

  case "$OS_TYPE" in
  mac) cat "$key_file" | pbcopy ;;
  win) cat "$key_file" | clip.exe ;;
  *) cat "$key_file" | xclip -selection clipboard ;;
  esac
  echo "SSH key for '$identifier' has been copied to clipboard."
}

ssh-key-list() {
  local pubkeys=("$HOME"/.ssh/id_rsa_*.pub(N))

  if [[ ${#pubkeys[@]} -eq 0 ]]; then
    echo "No named SSH keys found. Run 'bos --ssh generate' first."
    return 1
  fi

  for pub in "${pubkeys[@]}"; do
    local identifier="${${pub:t}#id_rsa_}"
    identifier="${identifier%.pub}"
    echo "$identifier  (git@github.${identifier}:...)"
  done
}

bos-append ssh key "Copy the unnamed SSH Key to clipboard" "ssh-copy"
bos-append ssh generate "Generate a new named SSH key and GitHub host alias" "ssh-key-generate"
bos-append ssh copy "Copy a named SSH key to clipboard" "ssh-key-copy"
bos-append ssh list "List named SSH keys" "ssh-key-list"
