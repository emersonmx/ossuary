#!/usr/bin/env bash

cat >.gitignore <<EOF
$(curl -L https://www.toptal.com/developers/gitignore/api/godot)

.envrc
EOF
