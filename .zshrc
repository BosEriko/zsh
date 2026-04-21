source ~/.zsh/env.z.sh
source ~/.zsh/sync.z.sh
source ~/.zsh/config.z.sh
source ~/.zsh/os-detection.z.sh
source ~/.zsh/help.z.sh
source ~/.zsh/setup.z.sh
source ~/.zsh/source.z.sh

# fnm
FNM_PATH="/opt/homebrew/opt/fnm/bin"
if [ -d "$FNM_PATH" ]; then
  eval "$(fnm env --shell zsh)"
fi
