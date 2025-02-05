#!/bin/bash
# shellcheck disable=SC2046

bash <(skf yolo/snippets/editorconfig/python)

bash <(skf yolo/snippets/pre-commit/python)

uv init
uv add --upgrade --dev $(skf snippets/python/devdeps)

bash <(skf yolo/snippets/direnv/python)
direnv allow

bash <(skf yolo/snippets/gitignore/python)

rm -f "$0"
