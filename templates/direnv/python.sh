#!/usr/bin/env bash

cat >.envrc <<EOF
export PYTHONBREAKPOINT=ipdb.set_trace
export PIP_REQUIRE_VIRTUALENV=true

$(skf direnv/source_file path=.venv/bin/activate)

$(skf direnv/dotenv)
EOF
