#!/usr/bin/env bash
# shellcheck disable=SC2046

set -euo pipefail

git init
shskf gitignore/rust.sh

cargo init --bin --vcs=none
cargo add anyhow thiserror
cargo add --dev $(skf rust/devdeps)

shskf editorconfig/rust.sh
shskf justfile/rust/setup.sh
shskf rustfmt/setup.sh
shskf githooks/setup.sh pre_commit=rust/pre-commit

skf env/rust >.env
skf direnv/dotenv >.envrc
direnv allow

just format
