#!/usr/bin/env bash
# shellcheck disable=SC2046

skf nodejs/package.json \
    name="{{ project_name | default(value="$(basename $PWD)") }}" \
    devdeps=$(skf nodejs/deps | tr '\n' ',') \
    >package.json
