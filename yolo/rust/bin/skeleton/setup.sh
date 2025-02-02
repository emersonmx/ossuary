#!/bin/bash
# shellcheck disable=SC2046

cat >.editorconfig <<EOF
$(skf snippets/editorconfig/base)

$(skf snippets/editorconfig/markdown)
EOF

cat >.envrc <<EOF
$(skf snippets/direnv/dotenv)
EOF
direnv allow .

cat >.gitignore <<EOF
$(curl -L https://www.toptal.com/developers/gitignore/api/rust)

.envrc
EOF

cargo init --bin

rm -f "$0"
