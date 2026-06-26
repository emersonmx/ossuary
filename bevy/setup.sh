#!/usr/bin/env bash
# shellcheck disable=SC2046

shskf gitignore/rust.sh

cargo init --bin --vcs=none
cargo add bevy --no-default-features --features 2d,ui
cargo add tracing --features max_level_debug,release_max_level_warn
cargo add --optional bevy-inspector-egui

shskf editorconfig/rust.sh
shskf justfile/rust/bevy/setup.sh
shskf rustfmt/setup.sh

skf direnv/dotenv >.envrc
direnv allow

mkdir -p .cargo/
skf bevy/dot_cargo_config.toml >.cargo/config.toml

sed '/^\[features\]/,$ d' -i Cargo.toml
cat >>Cargo.toml <<EOF
$(skf bevy/cargo_wasm_target.toml)

$(skf bevy/cargo_features.toml)

$(skf bevy/cargo_bevy_cli.toml)

$(skf bevy/cargo_lints.toml)

$(skf bevy/cargo_profile.toml)
EOF
rm -f Cargo.lock

skf bevy/lefthook.toml >lefthook.toml
skf bevy/clippy.toml >clippy.toml

project_name=$(basename "$PWD")

skf bevy/dev_tools.rs >src/dev_tools.rs
skf bevy/main.rs project_name="${project_name}" >src/main.rs

just format
