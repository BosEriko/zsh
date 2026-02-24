# ========================================================================== [Configuration] ===== #

bos-append docker start "Start Docker" "sudo service docker start"
bos-append docker bash "Start Bash for the current container" "sudo docker-compose exec web bash"
bos-append docker web "Run commands inside docker" "sudo docker-compose run web"
bos-append docker console "Start Rails console for the current container" "sudo docker-compose exec web rails c"
bos-append docker up "Start the current container" "sudo docker-compose up"
bos-append docker down "Stop the current container" "sudo docker-compose down"
bos-append docker unmount "Stop the current volumes" "sudo docker-compose down --volumes"
bos-append docker restart "Restart the current container" "sudo docker-compose down && sudo docker-compose up"
bos-append docker build "Build the current container" "sudo docker-compose build"
bos-append docker install "Install Gems automatically" "sudo docker-compose down && sudo docker-compose run web bundle install && sudo docker-compose up --build"
bos-append docker reset "Reset from schema" "sudo docker-compose run web rake db:schema:load"
