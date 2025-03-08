#!/bin/bash

cat >.pre-commit-config.yaml <<EOF
$(skf pre-commit/base.yaml)

$(skf pre-commit/ruff.yaml)

$(skf pre-commit/default_lint.yaml)

$(skf pre-commit/mypy.yaml)

$(skf pre-commit/vulture.yaml)
EOF
