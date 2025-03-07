#!/bin/bash
# shellcheck disable=SC2046

npx create-next-app@latest \
    . \
    --typescript \
    --tailwind \
    --app \
    --src-dir \
    --turbopack \
    --use-npm \
    --no-eslint \
    --yes

shskf yolo/snippets/editorconfig/nodejs
skf snippets/biome.json >biome.json

npm pkg set scripts.format="biome check --write . && rustywind --write ."
npm pkg set scripts.lint="biome lint . && rustywind --check-formatted ."

npm install --save-dev @biomejs/biome rustywind

npm run format

shskf yolo/snippets/direnv/nodejs
direnv allow
