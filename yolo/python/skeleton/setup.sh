#!/bin/bash
# shellcheck disable=SC2046

bash <(skf yolo/_snippets/editorconfig/python)

cat >.pre-commit-config.yaml <<EOF
$(skf snippets/pre-commit/base.yaml)

$(skf snippets/pre-commit/ruff.yaml)

$(skf snippets/pre-commit/default_lint.yaml)

$(skf snippets/pre-commit/mypy.yaml)

$(skf snippets/pre-commit/vulture.yaml)
EOF

uv init
uv add --upgrade --dev $(skf snippets/python/devdeps)

bash <(skf yolo/_snippets/direnv/python)
direnv allow .

bash <(skf yolo/_snippets/gitignore/python)

rm -f "$0"
