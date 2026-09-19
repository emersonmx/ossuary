#!/usr/bin/env bash

set -euo pipefail

git init
shskf gitignore/rust.sh

shskf editorconfig/rust.sh
shskf justfile/rust/setup.sh
shskf rustfmt/setup.sh

skf env/rust >.env
skf direnv/dotenv >.envrc
direnv allow

cat >Cargo.toml <<'EOF'
[workspace]
resolver = "3"
members = []

[profile.dev]
opt-level = 1

[profile.dev.package."*"]
opt-level = 3
EOF
