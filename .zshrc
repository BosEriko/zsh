# =========================================================== [Source Environment Variables] ===== #

[[ ! -f ~/env.z.sh ]] && return 0
source ~/env.z.sh

# ==================================================================== [Shell Configuration] ===== #

export SHELL=/bin/zsh
HISTFILESIZE=100000
HISTSIZE=10000
SAVEHIST=10000
export VISUAL=nvim
export EDITOR=nvim

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

# Initialize associative arrays
typeset -A BOS_CMDS
typeset -A BOS_DESC

# Append a new command dynamically (in memory)
bos-append() {
    local module="$1"
    local cmd="$2"
    local desc="$3"
    local shell_cmd="$4"

    local key="${module}:${cmd}"

    if [[ -n "${BOS_CMDS[$key]}" ]]; then
        echo "Command $module $cmd already exists."
        return 1
    fi

    BOS_CMDS[$key]="$shell_cmd"
    BOS_DESC[$key]="$desc"
}

bos() {
    # Show global help
    if [[ "$1" == "-h" || "$1" == "--help" || -z "$1" ]]; then
        echo "Available commands:"

        # Compute max lengths for alignment
        local max_flag=0
        local max_cmd=0
        for key in "${(@k)BOS_CMDS}"; do
            local module="${key%%:*}"
            local cmd="${key##*:}"
            local flag="-${module:0:1}/--$module"
            (( ${#flag} > max_flag )) && max_flag=${#flag}
            (( ${#cmd} > max_cmd )) && max_cmd=${#cmd}
        done

        # Colors
        local GREEN="\033[0;32m"
        local YELLOW="\033[0;33m"
        local NC="\033[0m"

        # Print all commands
        for key in "${(@k)BOS_CMDS}"; do
            local module="${key%%:*}"
            local cmd="${key##*:}"
            local desc="${BOS_DESC[$key]}"
            local flag="-${module:0:1}/--$module"

            printf "${GREEN}%-*s${NC}  ${YELLOW}%-*s${NC}  %s\n" \
                $max_flag "$flag" $max_cmd "$cmd" "$desc"
        done
        return
    fi

    # Parse module flag
    local flag="$1"
    shift
    local command="${1:-}"  # empty if no argument
    [[ -n "$1" ]] && shift

    local module=""
    if [[ "$flag" == --* ]]; then
        module="${flag:2}"
    elif [[ "$flag" == -* ]]; then
        local letter="${flag:1}"
        for key in "${(@k)BOS_CMDS}"; do
            local mod="${key%%:*}"
            if [[ "${mod:0:1}" == "$letter" ]]; then
                module="$mod"
                break
            fi
        done
        if [[ -z "$module" ]]; then
            echo "Unknown module for flag $flag"
            return 1
        fi
    else
        echo "Invalid module flag: $flag"
        return 1
    fi

    # Show module-specific help if no command provided
    if [[ -z "$command" ]]; then
        echo "Commands for module '$module':"

        # Compute max command length
        local max_cmd=0
        for key in "${(@k)BOS_CMDS}"; do
            [[ "${key%%:*}" == "$module" ]] || continue
            local cmd="${key##*:}"
            (( ${#cmd} > max_cmd )) && max_cmd=${#cmd}
        done

        # Colors
        local YELLOW="\033[0;33m"
        local NC="\033[0m"

        # Print commands with color
        for key in "${(@k)BOS_CMDS}"; do
            [[ "${key%%:*}" == "$module" ]] || continue
            local cmd="${key##*:}"
            local desc="${BOS_DESC[$key]}"
            printf "${YELLOW}%-*s${NC}  %s\n" $max_cmd "$cmd" "$desc"
        done
        return
    fi

    # Execute command
    local key="${module}:${command}"
    local shell_cmd="${BOS_CMDS[$key]}"
    if [[ -z "$shell_cmd" ]]; then
        echo "Command '$command' not found in module '$module'"
        return 1
    fi

    eval "$shell_cmd"
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

# ========================================================================= [Source Folders] ===== #

for folder in initializers modules programming; do
  base=~/.files/$folder
  [[ -d $base ]] || continue

  for dir in $base/*(/); do
    setup "$dir"
  done
done

