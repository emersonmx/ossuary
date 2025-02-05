#!/bin/bash

skf snippets/clang-format >.clang-format

bash <(skf yolo/snippets/editorconfig/c)

project_name=$(basename "$PWD")
skf snippets/cmake/base project_name="$project_name" >CMakeLists.txt
skf snippets/cmake/src project_name="$project_name" >src/CMakeLists.txt
skf snippets/cmake/tests >tests/CMakeLists.txt

echo "CC=clang" >.env
skf snippets/direnv/dotenv >.envrc
direnv allow

bash <(skf yolo/snippets/gitignore/c)

rm -f "$0"
