# ========================================================================== [Configuration] ===== #

if [[ "$OS_TYPE" == "stm" ]]; then
  alias docker="podman"
  alias docker-compose="podman-compose"
fi

bos-append manual docker "Print Docker Manual" "docker --help"
bos-append manual docker-compose "Print Docker Compose Manual" "docker-compose --help"
