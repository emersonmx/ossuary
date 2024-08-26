#!/bin/bash
# shellcheck disable=SC2046

cat >.editorconfig <<EOF
$(skf snippets/editorconfig/base)

$(skf snippets/editorconfig/makefile)

$(skf snippets/editorconfig/markdown)

$(skf snippets/editorconfig/yaml)
EOF

cat >.pre-commit-config.yaml <<EOF
$(skf snippets/pre-commit/base.yaml)

$(skf snippets/pre-commit/ruff.yaml)

$(skf snippets/pre-commit/default_lint.yaml)

$(skf snippets/pre-commit/mypy.yaml)

$(skf snippets/pre-commit/vulture.yaml)
EOF

python -m venv --upgrade-deps .venv

.venv/bin/python -m pip install --upgrade $(skf snippets/python/devdeps)

cat >.envrc <<EOF
export PYTHONBREAKPOINT=ipdb.set_trace
export PIP_REQUIRE_VIRTUALENV=true

$(skf snippets/direnv/source_file path=.venv/bin/activate)

$(skf snippets/direnv/dotenv)
EOF
direnv allow .

rm -f "$0"
