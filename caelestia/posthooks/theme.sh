#!/bin/bash

# Log the variables for debugging
echo "Scheme: $SCHEME_NAME | Flavour: $SCHEME_FLAVOUR | Mode: $SCHEME_MODE | Variant: $SCHEME_VARIANT"
echo "Colors:"
echo $SCHEME_COLOURS

cursor_light="Bibata-Modern-Ice"
cursor_dark="Bibata-Modern-Classic"
cursor_size="24"

# Determine which theme to use
if [[ "$SCHEME_MODE" == "dark" ]]; then
    target_cursor="$cursor_dark"
else
    target_cursor="$cursor_light"
fi

echo "Setting $SCHEME_MODE cursor: $target_cursor"

# Use the 'yes' pipe, but ensure the script path is correct
# We use quotes around variables to prevent issues with spaces
yes | ~/.config/caelestia/tools/cursor_install.sh "$target_cursor" "$cursor_size"

echo "Successfully set cursor to $SCHEME_MODE"