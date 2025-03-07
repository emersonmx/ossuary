#!/bin/bash

cat >.envrc <<EOF
export PYTHONBREAKPOINT=ipdb.set_trace
export PIP_REQUIRE_VIRTUALENV=true

$(skf snippets/direnv/source_file path=.venv/bin/activate)

$(skf snippets/direnv/dotenv)
EOF
