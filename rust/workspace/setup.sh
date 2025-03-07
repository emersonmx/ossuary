#!/bin/bash
# shellcheck disable=SC2046

shskf snippets/editorconfig/rust.sh

skf snippets/direnv/dotenv >.envrc
direnv allow

shskf snippets/gitignore/rust.sh

cat >Cargo.toml <<'EOF'
[workspace]
resolver = "2"
members = []

[profile.dev]
opt-level = 1

[profile.dev.package."*"]
opt-level = 3
EOF
