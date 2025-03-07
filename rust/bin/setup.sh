#!/bin/bash
# shellcheck disable=SC2046

shskf snippets/editorconfig/rust.sh

skf snippets/direnv/dotenv >.envrc
direnv allow

shskf snippets/gitignore/rust.sh

cargo init --bin
