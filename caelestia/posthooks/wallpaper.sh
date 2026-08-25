#!/bin/bash
echo $WALLPAPER_PATH

# Caelestia Greeter Dynamic theme sync.
sudo -n caelestia-greeter --sync

# AWWW for animated wallpapers
# awww img ~/.local/state/caelestia/wallpaper/current --transition-type grow --transition-pos center --transition-duration 2
# cp "$WALLPAPER_PATH" /usr/share/sddm/themes/pixie/assets/background.jpg