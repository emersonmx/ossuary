#!/bin/bash
# shellcheck disable=SC2046

git init
shskf gitignore/rust.sh

cargo init --lib

shskf editorconfig/rust.sh

skf direnv/dotenv >.envrc
direnv allow
