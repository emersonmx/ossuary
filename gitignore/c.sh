#!/bin/bash

cat >.gitignore <<EOF
$(curl -L https://www.toptal.com/developers/gitignore/api/c,cmake)

# Build
build
.cache

# Envs
.envrc
EOF
