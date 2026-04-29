#!/usr/bin/env bash

cat >justfile <<EOF
$(skf justfile/rust/build)

$(skf justfile/rust/run)

$(skf justfile/rust/watch)

$(skf justfile/rust/format)

$(skf justfile/rust/lint)

$(skf justfile/rust/lint-fix)

$(skf justfile/rust/ci)

$(skf justfile/rust/test)

$(skf justfile/rust/clean)
EOF
