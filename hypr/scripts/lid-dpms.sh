#!/usr/bin/env bash

HYPRCTL=/usr/bin/hyprctl
LOGINCTL=/usr/bin/loginctl

lid_state=$(cat /proc/acpi/button/lid/LID0/state | awk '{print $2}')
echo $lid_state

if [[ "$lid_state" == "closed" ]]; then
    $LOGINCTL lock-session
    if [[ $(caelestia shell lock isLocked) == "false" ]]; then
        caelestia shell lock lock
    fi
    $HYPRCTL dispatch dpms off
else
    $HYPRCTL dispatch dpms on
fi
