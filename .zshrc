# =========================================================== [Source Environment Variables] ===== #
[[ ! -f ~/env.z.sh ]] && return 0
source ~/env.z.sh

# ==================================================================== [Shell Configuration] ===== #
export SHELL=/bin/zsh
HISTFILE="$HOME/.zsh_history"
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
    # Show help
    if [[ "$1" == "-h" || "$1" == "--help" || -z "$1" ]]; then
        echo "Available commands:"
        
        local max_flag=0
        local max_cmd=0
        for key in "${(@k)BOS_CMDS}"; do
            local module="${key%%:*}"
            local cmd="${key##*:}"
            local flag="-${module:0:1}/--$module"
            (( ${#flag} > max_flag )) && max_flag=${#flag}
            (( ${#cmd} > max_cmd )) && max_cmd=${#cmd}
        done

        for key in "${(@k)BOS_CMDS}"; do
            local module="${key%%:*}"
            local cmd="${key##*:}"
            local desc="${BOS_DESC[$key]}"
            local flag="-${module:0:1}/--$module"

            local RED="\033[0;31m"
            local GREEN="\033[0;32m"
            local YELLOW="\033[0;33m"
            local NC="\033[0m"

            printf "${GREEN}%-*s${NC}  ${YELLOW}%-*s${NC}  %s\n" \
                $max_flag "$flag" $max_cmd "$cmd" "$desc"
        done
        return
    fi

    # Parse module flag
    local flag="$1"
    shift
    local command="$1"
    shift

    local module=""
    if [[ "$flag" == --* ]]; then
        module="${flag:2}"
    elif [[ "$flag" == -* ]]; then
        local letter="${flag:1}"
        # find module with that first letter
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

    # Execute command
    local key="${module}:${command}"
    local shell_cmd="${BOS_CMDS[$key]}"
    if [[ -z "$shell_cmd" ]]; then
        echo "Command '$command' not found in module '$module'"
        return 1
    fi

    eval "$shell_cmd"
}

# ================================================================================= [Colors] ===== #

# Reset
RESET='\033[0m'           # Text Reset

# Regular Colors
BLACK='\033[0;30m'        # Black
RED='\033[0;31m'          # Red
GREEN='\033[0;32m'        # Green
YELLOW='\033[0;33m'       # Yellow
BLUE='\033[0;34m'         # Blue
PURPLE='\033[0;35m'       # Purple
CYAN='\033[0;36m'         # Cyan
WHITE='\033[0;37m'        # White

# Bold
B_BLACK='\033[1;30m'      # Black
B_RED='\033[1;31m'        # Red
B_GREEN='\033[1;32m'      # Green
B_YELLOW='\033[1;33m'     # Yellow
B_BLUE='\033[1;34m'       # Blue
B_PURPLE='\033[1;35m'     # Purple
B_CYAN='\033[1;36m'       # Cyan
B_WHITE='\033[1;37m'      # White

# Underline
U_BLACK='\033[4;30m'      # Black
U_RED='\033[4;31m'        # Red
U_GREEN='\033[4;32m'      # Green
U_YELLOW='\033[4;33m'     # Yellow
U_BLUE='\033[4;34m'       # Blue
U_PURPLE='\033[4;35m'     # Purple
U_CYAN='\033[4;36m'       # Cyan
U_WHITE='\033[4;37m'      # White

# Background
ON_BLACK='\033[40m'       # Black
ON_RED='\033[41m'         # Red
ON_GREEN='\033[42m'       # Green
ON_YELLOW='\033[43m'      # Yellow
ON_BLUE='\033[44m'        # Blue
ON_PURPLE='\033[45m'      # Purple
ON_CYAN='\033[46m'        # Cyan
ON_WHITE='\033[47m'       # White

# High Intensity
I_BLACK='\033[0;90m'      # Black
I_RED='\033[0;91m'        # Red
I_GREEN='\033[0;92m'      # Green
I_YELLOW='\033[0;93m'     # Yellow
I_BLUE='\033[0;94m'       # Blue
I_PURPLE='\033[0;95m'     # Purple
I_CYAN='\033[0;96m'       # Cyan
I_WHITE='\033[0;97m'      # White

# Bold High Intensity
BI_BLACK='\033[1;90m'     # Black
BI_RED='\033[1;91m'       # Red
BI_GREEN='\033[1;92m'     # Green
BI_YELLOW='\033[1;93m'    # Yellow
BI_BLUE='\033[1;94m'      # Blue
BI_PURPLE='\033[1;95m'    # Purple
BI_CYAN='\033[1;96m'      # Cyan
BI_WHITE='\033[1;97m'     # White

# High Intensity backgrounds
OI_BLACK='\033[0;100m'    # Black
OI_RED='\033[0;101m'      # Red
OI_GREEN='\033[0;102m'    # Green
OI_YELLOW='\033[0;103m'   # Yellow
OI_BLUE='\033[0;104m'     # Blue
OI_PURPLE='\033[0;105m'   # Purple
OI_CYAN='\033[0;106m'     # Cyan
OI_WHITE='\033[0;107m'    # White

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

