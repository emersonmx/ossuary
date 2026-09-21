#!/usr/bin/env bash
# shellcheck disable=SC2046

pnpm add --save-dev --ignore-scripts \
    $(skf typescript/deps)

skf typescript/tsconfig.json types=node >tsconfig.json
skf typescript/tsconfig.build.json >tsconfig.build.json
