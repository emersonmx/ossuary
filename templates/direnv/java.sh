#!/usr/bin/env bash

set -euo pipefail

{% set jdtls_jvm_args = [] -%}
{%- set jdtls_jvm_args = [
    ...jdtls_jvm_args,
    "-javaagent:" ~ lombok_path,
] if lombok_path else jdtls_jvm_args -%}

skf direnv/dotenv >.envrc

cat >.env <<EOF
JDTLS_JVM_ARGS="{{ jdtls_jvm_args | join(sep=' ') }}"
EOF
