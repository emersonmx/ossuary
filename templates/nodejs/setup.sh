#!/usr/bin/env bash
# shellcheck disable=SC2046

pnpm init
pnpm pkg set \
    name="{{ project_name | default(value="$(basename $PWD)") }}"

pnpm add --save-dev --ignore-scripts \
    $(skf nodejs/devdeps)
