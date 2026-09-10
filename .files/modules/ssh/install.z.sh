# =========================================================================== [Installation] ===== #

if [[ "$OS_TYPE" == "stm" ]]; then
  nix-env -iA nixpkgs.xclip
fi

if [[ ! -f ~/.ssh/id_rsa ]]; then
  ssh-keygen -t rsa -b 4096 -C "boseriko@duck.com" -f ~/.ssh/id_rsa -N ""
fi

hosts=(
  github.com
  gitlab.com
  bitbucket.org
)
for host in "${hosts[@]}"; do
  ssh-keyscan -t rsa "$host" >>~/.ssh/known_hosts
done
