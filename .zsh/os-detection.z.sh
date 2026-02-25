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
