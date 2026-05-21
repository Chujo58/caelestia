#!/bin/bash

# Log the variables for debugging
echo "Scheme: $SCHEME_NAME | Flavour: $SCHEME_FLAVOUR | Mode: $SCHEME_MODE | Variant: $SCHEME_VARIANT"
echo "Colors:"
echo $SCHEME_COLOURS

~/.config/caelestia/posthooks/cursor.sh
~/.config/caelestia/posthooks/slack.sh