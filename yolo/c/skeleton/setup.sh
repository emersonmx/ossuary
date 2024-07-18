#!/bin/bash

skf c/snippets/clang-format >.clang-format
skf snippets/base_envrc >.envrc

echo "CC=clang" >.env

direnv allow .
