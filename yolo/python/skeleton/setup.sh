#!/bin/bash
# shellcheck disable=SC2046

sks python/editorconfig

python -m venv --upgrade-deps .venv

.venv/bin/python -m pip install --upgrade $(skf snippets/python/devdeps)

sks python/direnv
direnv allow .
