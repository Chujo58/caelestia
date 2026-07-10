#!/bin/bash

cat ~/.local/state/caelestia/scheme.json | jq -r '[
  .colours.primaryFixedDim,
  .colours.primaryContainer,
  .colours.surfaceContainerHighest,
  .colours.onPrimaryContainer,
  .colours.surfaceContainerHigh,
  .colours.onPrimaryFixed,
  .colours.success,
  .colours.error
] | map("#" + .) | join(",")'