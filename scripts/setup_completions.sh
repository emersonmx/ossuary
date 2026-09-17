#!/bin/bash

set -euo pipefail

current_dir="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
tools_dir="$current_dir/tools"
completions_dir="$tools_dir/completions"
install_dir="$HOME/.cache/zsh/completions"

mkdir -p "$install_dir"

for completion_file in "$completions_dir"/*; do
    if [[ -f "$completion_file" ]]; then
        ln -sf "$completion_file" "$install_dir/$(basename "$completion_file")"
        echo "Installed $(basename "$completion_file") to $install_dir"
    else
        echo "Warning: No completion files found in $completions_dir"
    fi
done
