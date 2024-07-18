#!/bin/bash

skf c/snippets/clang-format >.clang-format
skf snippets/direnv/dotenv >.envrc

echo "CC=clang" >.env

direnv allow .
