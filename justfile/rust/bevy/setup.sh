#!/usr/bin/env bash

cat >justfile <<EOF
set quiet

$(skf justfile/rust/bevy/setup)

$(skf justfile/rust/build)

$(skf justfile/rust/bevy/run)

$(skf justfile/rust/watch)

$(skf justfile/rust/format)

$(skf justfile/rust/bevy/lint)

$(skf justfile/rust/bevy/lint-fix)

$(skf justfile/rust/bevy/ci)

$(skf justfile/rust/test)

$(skf justfile/rust/clean)
EOF
