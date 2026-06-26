#!/usr/bin/env bash
# shellcheck disable=SC2046

shskf gitignore/rust.sh

cargo init --lib --vcs=none
cargo add thiserror
cargo add --dev $(skf rust/devdeps)

shskf editorconfig/rust.sh
shskf justfile/rust/setup.sh
shskf rustfmt/setup.sh

skf env/rust >.env
skf direnv/dotenv >.envrc
direnv allow

just format
