#!/usr/bin/env bash

cat >.envrc <<EOF
$(skf direnv/layout type=node)

$(skf direnv/dotenv)
EOF
