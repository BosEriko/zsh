# =========================================================== [Source Environment Variables] ===== #
[[ ! -f ~/env.z.sh ]] && return 0
source ~/env.z.sh

# ==================================================================== [Shell Configuration] ===== #
export SHELL=/bin/zsh
HISTFILESIZE=100000
HISTSIZE=10000

# =========================================================================== [Os Detection] ===== #
detect_os() {
  # macOS
  if [[ "$(uname -s)" == "Darwin" ]]; then
    echo "mac"
    return
  fi

  # WSL (Ubuntu on Windows)
  if grep -qi microsoft /proc/version 2>/dev/null; then
    echo "win"
    return
  fi

  # SteamOS
  if [[ -f /etc/os-release ]] && grep -qi steamos /etc/os-release; then
    echo "stm"
    return
  fi

  echo "unknown"
}
export OS_TYPE="$(detect_os)"

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
for folder in modules languages; do
  base=~/.files/$folder
  [[ -d $base ]] || continue

  for dir in $base/*(/); do
    setup "$dir"
  done
done

