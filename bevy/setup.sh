#!/usr/bin/env bash
# shellcheck disable=SC2046

{% set git = git | default(value="yes") %}
{%- if git == "yes" -%}
git init
shskf gitignore/rust.sh
{%- endif %}

cargo init --bin --vcs=none
cargo add anyhow thiserror bevy
cargo add log --features max_level_debug,release_max_level_warn
cargo add --dev $(skf rust/devdeps)

shskf editorconfig/rust.sh
shskf justfile/rust/bevy/setup.sh
shskf rustfmt/setup.sh

skf env/rust >.env
skf direnv/dotenv >.envrc
direnv allow

mkdir -p .cargo/
cat >.cargo/config.toml <<'EOF'
[target.x86_64-unknown-linux-gnu]
linker = "clang"
rustflags = ["-C", "link-arg=-fuse-ld=lld"]
EOF

sed -E 's/^log = \{ version = "[0-9.]+",/log = { version = "*",/' -i Cargo.toml
cat >>Cargo.toml <<'EOF'

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

cat >src/main.rs <<'EOF'
use bevy::prelude::*;

fn main() {
    App::new().add_plugins(DefaultPlugins).run();
}
EOF

just format
