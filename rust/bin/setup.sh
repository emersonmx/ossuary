#!/bin/bash
# shellcheck disable=SC2046

shskf editorconfig/rust.sh

skf direnv/dotenv >.envrc
direnv allow

shskf gitignore/rust.sh

cargo init --bin
