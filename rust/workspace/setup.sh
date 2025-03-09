#!/bin/bash
# shellcheck disable=SC2046

git init
shskf gitignore/rust.sh

shskf editorconfig/rust.sh

skf direnv/dotenv >.envrc
direnv allow

cat >Cargo.toml <<'EOF'
[workspace]
resolver = "2"
members = []

[profile.dev]
opt-level = 1

[profile.dev.package."*"]
opt-level = 3
EOF
