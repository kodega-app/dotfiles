#!/usr/bin/env bash

# Handle toggle action
if [ "$1" = "--toggle" ]; then
    if bluetoothctl show | grep -q "Powered: yes"; then
        bluetoothctl power off >/dev/null 2>&1
    else
        bluetoothctl power on >/dev/null 2>&1
    fi
    exit 0
fi

# Check powered state
if ! bluetoothctl show 2>/dev/null | grep -q "Powered: yes"; then
    echo "%{F#6c7086}󰂲 off%{F-}"
    exit 0
fi

# Check connected devices
connected=$(bluetoothctl devices Connected 2>/dev/null | head -n 1 | cut -d ' ' -f 3-)
if [ -n "$connected" ]; then
    echo "%{F#89b4fa}󰂱 %{F-}$connected"
else
    echo "%{F#89b4fa}󰂯%{F-} on"
fi
