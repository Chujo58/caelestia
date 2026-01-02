#!/bin/bash

# Reload Caelestia
qs -c caelestia kill
sleep 1
caelestia shell -d

# Reload overview
pkill -f "qs -c overview"
sleep 1
qs -c overview -d