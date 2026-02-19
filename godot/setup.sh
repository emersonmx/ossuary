#!/usr/bin/env bash

git init
shskf gitignore/godot.sh

touch project.godot

shskf editorconfig/godot.sh
skf justfile/godot >justfile

skf direnv/dotenv >.envrc
direnv allow
