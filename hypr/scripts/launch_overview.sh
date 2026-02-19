#!/bin/bash
# ~/.config/hypr/qs-overview.sh

export XDG_SESSION_TYPE=wayland
export WAYLAND_DISPLAY=wayland-1
export DBUS_SESSION_BUS_ADDRESS="$DBUS_SESSION_BUS_ADDRESS"

# Check if qs is running
if pgrep -x "qs" > /dev/null; then
    # Send the overview command to the existing instance
    qs -c overview -d
else
    # Start qs fresh
    qs -c overview -d &
fi
