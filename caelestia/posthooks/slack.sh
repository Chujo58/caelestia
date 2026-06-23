#!/bin/bash

cat ~/.local/state/caelestia/scheme.json | jq -r '[
  .colours.background, 
  .colours.surfaceContainerHigh,
  .colours.primaryContainer,
  .colours.onPrimaryContainer,
  .colours.surfaceContainerLow,
  .colours.text,
  .colours.success,
  .colours.error
] | map("#" + .) | join(",")'
