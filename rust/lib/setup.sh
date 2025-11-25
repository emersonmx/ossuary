#!/usr/bin/env bash
# shellcheck disable=SC2046

git init
shskf gitignore/rust.sh

cargo init --lib
cargo add thiserror

shskf editorconfig/rust.sh
skf justfile/rust >justfile

skf direnv/dotenv >.envrc
direnv allow

just format
