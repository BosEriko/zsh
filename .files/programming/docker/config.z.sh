# ========================================================================== [Configuration] ===== #

bos-append docker start "Start Docker" "service docker start"
bos-append docker bash "Start Bash for the current container" "docker-compose exec web bash"
bos-append docker web "Run commands inside docker" "docker-compose run web"
bos-append docker console "Start Rails console for the current container" "docker-compose exec web rails c"
bos-append docker up "Start the current container" "docker-compose up"
bos-append docker down "Stop the current container" "docker-compose down"
bos-append docker unmount "Stop the current volumes" "docker-compose down --volumes"
bos-append docker restart "Restart the current container" "docker-compose down && docker-compose up"
bos-append docker build "Build the current container" "docker-compose build"
bos-append docker install "Install Gems automatically" "docker-compose down && docker-compose run web bundle install && docker-compose up --build"
bos-append docker reset "Reset from schema" "docker-compose run web rake db:schema:load"
