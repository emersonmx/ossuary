#!/usr/bin/env bash
# shellcheck disable=SC2046

shskf pnpm/init.sh project_name="{{ project_name | default(value="$(basename $PWD)") }}"

pnpm add --save-dev --ignore-scripts \
    $(skf nodejs/deps)
