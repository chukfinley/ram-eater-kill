#!/bin/bash

PROCENT=70
SECOUNDS=1

# Function to send notification
send_notification() {
    # Get the user running the desktop session
    user=$(who | awk '{print $1}' | head -n 1)

    # Get the user's DBUS_SESSION_BUS_ADDRESS
    DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$(pgrep -u $user gnome-session|head -n1)/environ | cut -d= -f2-)

    # Send notification
    sudo -u $user DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS notify-send "$1" "$2"
}

while true; do
    # Get total RAM and used RAM in KB
    total_ram=$(grep MemTotal /proc/meminfo | awk '{print $2}')
    free_ram=$(grep MemAvailable /proc/meminfo | awk '{print $2}')

    # Calculate used RAM
    used_ram=$((total_ram - free_ram))

    # Calculate RAM usage percentage
    ram_usage=$((used_ram * 100 / total_ram))

    if [ $ram_usage -ge $PROCENT ]; then
        # Find the process using the most RAM
        top_process=$(ps aux --sort=-%mem | awk 'NR==2 {print $2 " " $11}')
        pid=$(echo $top_process | cut -d' ' -f1)
        name=$(echo $top_process | cut -d' ' -f2)

        # Kill the process
        kill $pid

        # Send notification
        send_notification "High RAM Usage" "Killed process: $name (PID: $pid) due to high RAM usage (${ram_usage}%)"

        # Log the action
        logger "RAM Monitor: Killed process $name (PID: $pid) due to high RAM usage (${ram_usage}%)"
    fi

    # Sleep for 1 minute before checking again
    sleep $SECOUNDS
done
