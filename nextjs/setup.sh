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

shskf editorconfig/nodejs.sh
skf biome/biome.json >biome.json

npm pkg set scripts.format="rustywind --write . && biome format --write ."
npm pkg set scripts.lint="rustywind --check-formatted . && biome check . && tsc --noEmit"

npm install --save-dev $(skf typescript/devdeps) rustywind

shskf direnv/nodejs.sh
direnv allow

npm run format
