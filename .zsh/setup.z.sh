# ================================================================================== [Setup] ===== #

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
