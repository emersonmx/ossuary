#!/usr/bin/env bash

git init
shskf gitignore/godot.sh

touch project.godot
curl \
    -L \
    -o icon.svg \
    https://raw.githubusercontent.com/godotengine/godot/refs/heads/master/editor/icons/DefaultProjectIcon.svg

shskf editorconfig/godot.sh
skf justfile/godot >justfile

skf direnv/dotenv >.envrc
direnv allow
