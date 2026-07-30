#!/usr/bin/env bash

active_win=$(/usr/bin/hyprctl activewindow -j)

if [ -z "$active_win" ] || [ "$active_win" = "{}" ]; then
    exit 0
fi

fullscreen_val=$(echo "$active_win" | jq -r '.fullscreen')
is_floating=$(echo "$active_win" | jq -r '.floating')

direction="$1" # "outward" or "inward"

echo $fullscreen_val $is_floating
if [ "$direction" == "outward" ]; then
    if [ "$fullscreen_val" -eq 0 ] && [ "$is_floating" == "false" ]; then
        hyprctl dispatch 'hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" })'
    elif [ "$is_floating" == "true" ]; then
        hyprctl dispatch 'hl.dsp.window.float({ action = "toggle" })'
    fi

elif [ "$direction" == "inward" ]; then
    if [ "$fullscreen_val" -gt 0 ] && [ "$is_floating" == "false" ]; then
        hyprctl dispatch 'hl.dsp.window.fullscreen({ mode = "fullscreen", action = "unset" })'
    elif [ "$fullscreen_val" -eq 0 ] && [ "$is_floating" == "false" ]; then
        hyprctl dispatch 'hl.dsp.window.float({ action = "toggle" })'
    fi
fi