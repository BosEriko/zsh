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

# =================================================================================== [Help] ===== #
typeset -gA BOS_REGISTRY

bos-append() {
  local module="$1"
  shift

  local short=""
  local long=""
  local command=""
  local exec_cmd=""
  local description=""

  for arg in "$@"; do
    case "$arg" in
      short=*) short="${arg#short=}" ;;
      long=*) long="${arg#long=}" ;;
      command=*) command="${arg#command=}" ;;
      exec=*) exec_cmd="${arg#exec=}" ;;
      desc=*) description="${arg#desc=}" ;;
    esac
  done

  if [[ -z "$module" || -z "$short" || -z "$long" || -z "$command" || -z "$exec_cmd" ]]; then
    echo "Invalid bos-append usage"
    return 1
  fi

  # store flags once per module
  BOS_REGISTRY["$module:short"]="$short"
  BOS_REGISTRY["$module:long"]="$long"

  # store command data
  BOS_REGISTRY["$module:$command:exec"]="$exec_cmd"
  BOS_REGISTRY["$module:$command:desc"]="$description"
}

bos-help() {
  echo "Available commands:"
  echo

  local modules=()

  # collect modules
  for key in ${(k)BOS_REGISTRY}; do
    modules+=("${key%%:*}")
  done

  modules=(${(u)modules})  # unique

  for module in $modules; do
    local short="${BOS_REGISTRY[$module:short]}"
    local long="${BOS_REGISTRY[$module:long]}"

    [[ -z "$short" ]] && continue

    echo "-$short, --$long"

    for key in ${(k)BOS_REGISTRY}; do
      if [[ "$key" == "$module":*:exec ]]; then
        local cmd="${key#"$module:"}"
        cmd="${cmd%:exec}"
        local desc="${BOS_REGISTRY[$module:$cmd:desc]}"

        printf "   %-10s %s\n" "$cmd" "$desc"
      fi
    done

    echo
  done
}

bos() {
  if [[ "$1" == "-h" || "$1" == "--help" || -z "$1" ]]; then
    bos-help
    return
  fi

  local flag="$1"
  local subcommand="$2"

  for key in ${(k)BOS_REGISTRY}; do
    local module="${key%%:*}"
    local type="${key##*:}"

    if [[ "$type" == "short" ]]; then
      local short="${BOS_REGISTRY[$module:short]}"
      local long="${BOS_REGISTRY[$module:long]}"

      if [[ "$flag" == "-$short" || "$flag" == "--$long" ]]; then
        local exec_cmd="${BOS_REGISTRY[$module:$subcommand:exec]}"
        if [[ -n "$exec_cmd" ]]; then
          eval "$exec_cmd"
          return
        else
          echo "Unknown subcommand '$subcommand'"
          return 1
        fi
      fi
    fi
  done

  echo "Unknown flag: $flag"
}

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

