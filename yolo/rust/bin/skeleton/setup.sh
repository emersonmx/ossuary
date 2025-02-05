#!/bin/bash
# shellcheck disable=SC2046

bash <(skf yolo/snippets/editorconfig/rust)

skf snippets/direnv/dotenv >.envrc
direnv allow .

bash <(skf yolo/snippets/gitignore/rust)

cargo init --bin

rm -f "$0"
