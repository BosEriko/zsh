# =========================================================================== [Installation] ===== #

# Install xclip
if [[ "$OS_TYPE" == "stm" ]]; then
  command -v xclip >/dev/null 2>&1 || nix-env -iA nixpkgs.xclip
fi

# Generate SSH key
if [ ! -f ~/.ssh/id_rsa ]; then
  ssh-keygen -t rsa -b 4096 -C "boseriko@duck.com" -f ~/.ssh/id_rsa -N ""
fi

# Trust Git hosts
hosts=(
  github.com
  gitlab.com
  bitbucket.org
)
for host in "${hosts[@]}"; do
  ssh-keygen -F "$host" >/dev/null 2>&1 || ssh-keyscan -t rsa "$host" >>~/.ssh/known_hosts
done
