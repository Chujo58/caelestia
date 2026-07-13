#!/usr/bin/env bash

caelestia shell idleInhibitor toggle
if [[ "$(caelestia shell idleInhibitor isEnabled)" = "true" ]]; then
    caelestia shell toaster info "Keep awake" "Turned on!" "coffee"
else
    caelestia shell toaster info "Keep awake" "Turned off!" "coffee"
fi