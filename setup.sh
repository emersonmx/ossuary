#!/bin/bash

set -euo pipefail

current_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
scripts_dir="$current_dir/scripts"
install_dir="$HOME/.local/bin"

mkdir -p "$install_dir"

scripts=(
    shskf
    sk
    skf
    skls
    sks
)

for script in "${scripts[@]}"; do
    if [[ -f "$scripts_dir/$script" ]]; then
        ln -sf "$scripts_dir/$script" "$install_dir/$script"
        echo "Installed $script to $install_dir"
    else
        echo "Warning: $script not found in $scripts_dir"
    fi
done
