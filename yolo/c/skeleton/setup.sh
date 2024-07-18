#!/bin/bash

skf c/snippets/clang-format >.clang-format

cat >.editorconfig <<EOF
$(skf snippets/editorconfig/base)

$(skf snippets/editorconfig/makefile)

$(skf snippets/editorconfig/markdown)
EOF

echo "CC=clang" >.env

skf snippets/direnv/dotenv >.envrc
direnv allow .
