#!/bin/bash
# shellcheck disable=SC2046

shskf yolo/snippets/editorconfig/rust

skf snippets/direnv/dotenv >.envrc
direnv allow

shskf yolo/snippets/gitignore/rust

cargo init --bin

rm -f "$0"
