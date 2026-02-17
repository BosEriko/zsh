# =========================================================== [Source Environment Variables] ===== #
[[ ! -f ~/env.z.sh ]] && return 0
source ~/env.z.sh

# ==================================================================== [Shell Configuration] ===== #
export SHELL=/bin/zsh
HISTFILESIZE=100000
HISTSIZE=10000

# =========================================================================== [Os Detection] ===== #
if [[ "$(uname -s)" == "Darwin" ]]; then
  export OS_TYPE="mac"
elif grep -qi microsoft /proc/version 2>/dev/null; then
  export OS_TYPE="win"
elif [[ -f /etc/os-release ]] && grep -qi steamos /etc/os-release; then
  export OS_TYPE="stm"
else
  export OS_TYPE="n/a"
fi

# ========================================================= [Automate Install/Configuration] ===== #
INSTALL_STATE="$HOME/.install-state"
[[ -d "$INSTALL_STATE" ]] || mkdir -p "$INSTALL_STATE"
setup() {
  local module_dir="$1"
  local state_file="$INSTALL_STATE/${${module_dir#$HOME/.files/}//\//.}"

  if [[ ! -f "$state_file" ]]; then
    if [[ -f "$module_dir/install.z.sh" ]]; then
      if source "$module_dir/install.z.sh"; then
        touch "$state_file"
        cd ~
        git checkout .
        git clean -fd
      else
        echo "❌ Install failed for $module_dir"
        return 1
      fi
    else
      touch "$state_file"
    fi
  fi

  [[ -f "$module_dir/config.z.sh" ]] && source "$module_dir/config.z.sh"
}

# =============================================================== [Source Modules/Languages] ===== #
for folder in initializers modules languages; do
  base=~/.files/$folder
  [[ -d $base ]] || continue

  for dir in $base/*(/); do
    setup "$dir"
  done
done

