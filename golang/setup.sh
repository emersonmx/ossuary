#!/usr/bin/env bash
# shellcheck disable=SC2046

git init
shskf gitignore/golang.sh

go mod init {{ module_path | default(value='example.com/$(basename "$PWD")') }}

shskf editorconfig/golang.sh
skf justfile/golang >justfile

cat >main.go <<'EOF'
package main

import "fmt"

func main() {
	fmt.Println("Hello World")
}
EOF

just format
