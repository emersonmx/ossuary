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
opt-level = {{ profile_dev_opt_level | default(value=1) }}

[profile.dev.package."*"]
opt-level = {{ profile_dev_package_opt_level | default(value=3) }}
EOF
