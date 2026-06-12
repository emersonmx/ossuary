#!/usr/bin/env bash
# shellcheck disable=SC2046

{% set git = git | default(value="yes") %}
{%- if git == "yes" -%}
git init
shskf gitignore/rust.sh
{%- endif %}

cargo init --bin --vcs=none
cargo add anyhow thiserror bevy bevy-inspector-egui
cargo add log --features max_level_debug,release_max_level_warn
cargo add tracing --features max_level_debug,release_max_level_warn
cargo add --dev $(skf rust/devdeps)

shskf editorconfig/rust.sh
shskf justfile/rust/bevy/setup.sh
shskf rustfmt/setup.sh

skf env/rust >.env
skf direnv/dotenv >.envrc
direnv allow

mkdir -p .cargo/
skf bevy/cargo_config.toml >.cargo/config.toml

cat >>Cargo.toml <<EOF

$(skf bevy/cargo_lints.toml)

$(skf bevy/cargo_profile.toml)
EOF
rm -f Cargo.lock

project_name=$(basename "$PWD")

skf bevy/debug_plugins.rs >src/debug_plugins.rs
skf bevy/main.rs project_name="${project_name}" >src/main.rs

just format
