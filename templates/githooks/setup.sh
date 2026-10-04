#!/usr/bin/env bash

set -euo pipefail

githooks_dir=".githooks"

git config core.hooksPath $githooks_dir

mkdir -p $githooks_dir

skf githooks/pre-commit >$githooks_dir/pre-commit
chmod +x $githooks_dir/pre-commit
