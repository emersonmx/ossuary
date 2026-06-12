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

cat >>Cargo.toml <<'EOF'

[lints.clippy]
too_many_arguments = "allow"
type_complexity = "allow"

[profile.dev]
opt-level = 1

[profile.dev.package."*"]
opt-level = 3

[profile.dev.package.wgpu-types]
debug-assertions = false

[profile.release]
codegen-units = 1
lto = "thin"

[profile.wasm-release]
inherits = "release"
opt-level = "s"
strip = "debuginfo"
EOF
rm -f Cargo.lock

skf bevy/debug_plugins.rs >src/debug_plugins.rs

cat >src/main.rs <<'EOF'
use bevy::prelude::*;
use debug_plugins::DebugPlugins;

mod debug_plugins;

fn main() {
    App::new().add_plugins(DefaultPlugins).run();
}
EOF

just format
