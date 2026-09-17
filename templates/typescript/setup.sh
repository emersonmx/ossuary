#!/usr/bin/env bash
# shellcheck disable=SC2046

pnpm add --save-dev --ignore-scripts \
    $(skf typescript/devdeps)

pnpm exec tsc \
    --init \
    --types node

sed -E \
    -e '\#^\s+//#d' \
    -e 's#/\*.*\*/##g' \
    -e '/^\s*$/d' \
    -i tsconfig.json
