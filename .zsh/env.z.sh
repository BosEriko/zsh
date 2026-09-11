# ==================================================================================== [ENV] ===== #

ENV_FILE=~/env.z.sh

[[ -f "$ENV_FILE" ]] || cp ~/example.env.z.sh "$ENV_FILE"
grep -q "XXXX" "$ENV_FILE" && vim "$ENV_FILE"

if grep -q "XXXX" "$ENV_FILE"; then
  echo "env.z.sh still has placeholder values, aborting shell startup"
  exit 1
fi

source "$ENV_FILE"
