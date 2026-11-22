#!/usr/bin/env bash

cat >justfile <<EOF
$(skf justfile/rust/base)

$(skf justfile/rust/default)

$(skf justfile/rust/setup)

$(skf justfile/rust/build)

$(skf justfile/rust/run)

$(skf justfile/rust/watch)

$(skf justfile/rust/format)

$(skf justfile/rust/check)

$(skf justfile/rust/lint)

$(skf justfile/rust/format_check)

$(skf justfile/rust/vet)

$(skf justfile/rust/secrets)

$(skf justfile/rust/test)

$(skf justfile/rust/audit)

$(skf justfile/rust/clean)
EOF
