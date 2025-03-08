#!/bin/bash

cat >.envrc <<EOF
$(skf direnv/add_to_path path="node_modules/.bin")

$(skf direnv/dotenv)
EOF
