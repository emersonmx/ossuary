#!/bin/bash
# shellcheck disable=SC2046

project_name=$(basename "$PWD")
module_path="example.com/$project_name"
gh_username="$(git config github.user)"
[[ -n "$gh_username" ]] && module_path="github.com/$gh_username/$project_name"

git init
shskf gitignore/golang.sh

go mod init "$module_path"

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
