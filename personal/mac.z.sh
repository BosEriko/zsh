
# =============================================================================== [Personal] ===== #

FIGLET_MESSAGE="boseriko.com"
BOS_HELP_MESSAGE="

    This is a helper showing all your Bos commands.


    Usage: bos [option] [command]

${B_GREEN}
    Options:                    Commands:               Description:
${RESET}

    -a, --assist                path                    Print out the list of paths
                                resource                Restart ZSH
                                services                List all running brew services

    -s, --services              colima                  Toggle Colima service
                                psql                    Toggle PostgreSQL service
                                redis                   Toggle Redis service

    -y, --yarn                  list                    List global yarn packages
                                interactive             Upgrade global yarn packages interactively
                                upgrade                 Upgrade global yarn packages

    -p, --programming           external-ip             Show external IP address
                                ssh-key                 Copy Main SSH Key to clipboard
                                rbenv-rehash            Run Rehash on rbenv

"
bos() {
    if [ -z "$1" ]; then
        echo "Type -h or --help to print all the Bos commands."
    else
        if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
            (cd ~; figlet $FIGLET_MESSAGE | lolcat && echo -e $BOS_HELP_MESSAGE;)
        elif [ "$1" = "-a" ] || [ "$1" = "--assist" ]; then
            if [ "$2" = "path" ]; then
                echo $PATH | tr \: \\n
            elif [ "$2" = "resource" ]; then
                source ~/.zshrc
                echo 'ZSH has been restarted!'
            elif [ "$2" = "services" ]; then
                declare -A SERVICE_MAP=(
                    [colima]="colima"
                    [psql]="postgresql@14"
                    [redis]="redis"
                )
                LIST=$(brew services list)
                for KEY in colima psql redis; do
                    BREW_NAME="${SERVICE_MAP[$KEY]}"
                    STATUS=$(echo "$LIST" | awk -v name="$BREW_NAME" '$1==name {print $2}')
                    case "$STATUS" in
                        started)
                            echo -e "$KEY is \033[32mrunning\033[0m."
                            ;;
                        error)
                            echo -e "$KEY is \033[33merror\033[0m."
                            ;;
                        *)
                            echo -e "$KEY is \033[31mnot running\033[0m."
                            ;;
                    esac
                done
                echo -e "\nFor more information, run \`brew services list\`."
            else
                echo "Usage: -a <command> or --assist <command>"
            fi
        elif [ "$1" = "-s" ] || [ "$1" = "--services" ]; then
            SERVICE=""
            case "$2" in
                borders) SERVICE="borders"; DESC="Borders";;
                colima) SERVICE="colima"; DESC="Colima";;
                psql) SERVICE="postgresql@14"; DESC="PostgreSQL";;
                redis) SERVICE="redis"; DESC="Redis";;
                sketchybar) SERVICE="sketchybar"; DESC="SketchyBar";;
                *) echo "Usage: -s <service> or --services <service>"; return;;
            esac

            STATUS=$(brew services list | grep "^$SERVICE" | awk '{print $2}')
            if [ "$STATUS" = "started" ]; then
                echo "Stopping $DESC service..."
                brew services stop "$SERVICE"
                echo "$DESC service stopped."
            else
                echo "Starting $DESC service..."
                brew services start "$SERVICE"
                echo "$DESC service started."
            fi
        elif [ "$1" = "-y" ] || [ "$1" = "--yarn" ]; then
            if [ "$2" = "list" ]; then
                yarn global list
            elif [ "$2" = "interactive" ]; then
                yarn global upgrade-interactive
            elif [ "$2" = "upgrade" ]; then
                yarn global upgrade --latest
            else
                echo "Usage: -y <command> or --yarn <command>"
            fi
        elif [ "$1" = "-p" ] || [ "$1" = "--programming" ]; then
            if [ "$2" = "external-ip" ]; then
                EXTERNALIP=$(curl -sS ipinfo.io/ip)
                echo $EXTERNALIP
            elif [ "$2" = "ssh-key" ]; then
                cat ~/.ssh/id_rsa.pub | pbcopy
                echo "SSH Key has been copied to clipboard."
            elif [ "$2" = "rbenv-rehash" ]; then
                rbenv rehash
            else
                echo "Usage: -p <command> or --programming <command>"
            fi
        else
            echo "Command not found: $1"
        fi
    fi
}
