#!/usr/bin/env bash
# shellcheck disable=SC2046

cat >rustfmt.toml <<EOF
$(skf rustfmt/base)

$(skf rustfmt/unstable)
EOF
