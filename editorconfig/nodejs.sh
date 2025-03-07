#!/bin/bash

cat >.editorconfig <<EOF
$(skf snippets/editorconfig/base)

$(skf snippets/editorconfig/makefile)

$(skf snippets/editorconfig/markdown)

$(skf snippets/editorconfig/html)

$(skf snippets/editorconfig/yaml)
EOF
