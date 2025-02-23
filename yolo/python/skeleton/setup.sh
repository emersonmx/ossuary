#!/bin/bash
# shellcheck disable=SC2046

shskf yolo/snippets/editorconfig/python

shskf yolo/snippets/pre-commit/python

uv init
uv add --upgrade --dev $(skf snippets/python/devdeps)

shskf yolo/snippets/direnv/python
direnv allow

shskf yolo/snippets/gitignore/python

rm -f "$0"
