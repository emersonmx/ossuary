#!/usr/bin/env bash
# shellcheck disable=SC2046

pnpm pkg set \
    scripts.build="{{ build }}" \
    scripts.start="{{ start }}" \
    scripts.test="{{ test }}" \
    scripts.format="{{ format }}" \
    scripts.lint="{{ lint }}"
