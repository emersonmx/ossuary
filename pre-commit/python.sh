#!/bin/bash

cat >.pre-commit-config.yaml <<EOF
$(skf snippets/pre-commit/base.yaml)

$(skf snippets/pre-commit/ruff.yaml)

$(skf snippets/pre-commit/default_lint.yaml)

$(skf snippets/pre-commit/mypy.yaml)

$(skf snippets/pre-commit/vulture.yaml)
EOF
