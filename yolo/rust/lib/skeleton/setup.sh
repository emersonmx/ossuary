#!/bin/bash
# shellcheck disable=SC2046

bash <(skf yolo/_snippets/editorconfig/rust)

skf snippets/direnv/dotenv >.envrc
direnv allow .

bash <(skf yolo/_snippets/gitignore/rust)

cargo init --lib

rm -f "$0"
