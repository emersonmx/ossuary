#!/usr/bin/env bash
# shellcheck disable=SC2046

{% set git = git | default(value="yes") %}
{%- if git == "yes" -%}
git init
shskf gitignore/rust.sh
{%- endif %}

cargo init --bin --vcs=none
cargo add anyhow thiserror
cargo add --dev $(skf rust/devdeps)

shskf editorconfig/rust.sh
shskf justfile/rust/setup.sh
shskf rustfmt/setup.sh

skf env/rust >.env
skf direnv/dotenv >.envrc
direnv allow

just format
