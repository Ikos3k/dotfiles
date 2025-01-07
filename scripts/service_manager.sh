#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CLEAR='\033[0m'

declare -a services=(
    "smbd"
    "sshd"
    "jellyfin"
    "apache2"
    "nginx"
    "mysql"
    "bluetooth"
    "NetworkManager"
    "dnsmasq"
    "polkit"
)

get_all_services() {
    available_services=()
    for service in "${services[@]}"; do
        if systemctl list-unit-files --type=service --all | grep -q "^$service.service"; then
            available_services+=("$service")
        fi
    done
}

check_status() {
    local service_name="$1"
    systemctl is-active --quiet "$service_name"
}

check_autostart() {
    local service_name="$1"
    systemctl is-enabled --quiet "$service_name"
}

start_service() {
    local service_name="$1"
    systemctl start "$service_name"
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}$service_name has been started for the current session${CLEAR}"
    else
        echo -e "${RED}Failed to start $service_name for the current session${CLEAR}"
    fi
}

stop_service() {
    local service_name="$1"
    systemctl stop "$service_name"
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}$service_name has been stopped for the current session${CLEAR}"
    else
        echo -e "${RED}Failed to stop $service_name for the current session${CLEAR}"
    fi
}

enable_autostart() {
    local service_name="$1"
    systemctl enable "$service_name"
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}$service_name has been enabled for autostart${CLEAR}"
    else
        echo -e "${RED}Failed to enable $service_name for autostart${CLEAR}"
    fi
}

disable_autostart() {
    local service_name="$1"
    systemctl disable "$service_name"
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}$service_name has been disabled for autostart${CLEAR}"
    else
        echo -e "${RED}Failed to disable $service_name for autostart${CLEAR}"
    fi
}

while true; do
    clear
    echo "Available Services:"

    get_all_services

    index=1
    for service_command in "${available_services[@]}"; do
        if check_status "$service_command"; then
            status="${GREEN}active${CLEAR}"
        else
            status="${RED}inactive${CLEAR}"
        fi

        if check_autostart "$service_command"; then
            autostart_status="${GREEN}enabled${CLEAR}"
        else
            autostart_status="${RED}disabled${CLEAR}"
        fi

        echo -e "$index. $service_command - $status [$autostart_status]"
        ((index++))
    done

    read -p "Enter the number of the service: " choice

    if [[ $choice -ge 1 && $choice -lt $index ]]; then
        service_command=${available_services[$choice - 1]}
        echo "1. Start/Stop for Current Session"
        echo "2. Enable/Disable for Autostart"
        read -p "Enter your choice: " sub_choice
        case $sub_choice in
            1)
                if check_status "$service_command"; then
                    stop_service "$service_command"
                else
                    start_service "$service_command"
                fi
                ;;
            2)
                if check_autostart "$service_command"; then
                    disable_autostart "$service_command"
                else
                    enable_autostart "$service_command"
                fi
                ;;
            *) echo -e "${RED}Invalid choice${CLEAR}";;
        esac
    else
        echo -e "${RED}Invalid choice${CLEAR}"
    fi

    read -p "Press Enter to continue..."
done
