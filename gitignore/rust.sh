#!/bin/bash

cat >.gitignore <<EOF
$(curl -L https://www.toptal.com/developers/gitignore/api/rust)

.envrc
EOF
