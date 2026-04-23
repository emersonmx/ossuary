#!/usr/bin/env bash
# shellcheck disable=SC2046

{% set git = git | default(value="yes") %}
{%- if git == "yes" -%}
git init
shskf gitignore/rust.sh
{%- endif %}

cargo init --lib --vcs=none
cargo add thiserror

shskf editorconfig/rust.sh
skf justfile/rust >justfile

skf direnv/dotenv >.envrc
direnv allow

just format
