#!/bin/bash

set -euo pipefail

current_dir="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
tools_dir="$current_dir/tools"
install_dir="$HOME/.local/bin"

mkdir -p "$install_dir"

tools=(
    shskf
    sk
    skf
    skls
    sks
)

for tool in "${tools[@]}"; do
    if [[ -f "$tools_dir/$tool" ]]; then
        ln -sf "$tools_dir/$tool" "$install_dir/$tool"
        echo "Installed $tool to $install_dir"
    else
        echo "Warning: $tool not found in $tools_dir"
    fi
done
