#!/bin/bash
# shellcheck disable=SC2046

shskf snippets/editorconfig/nodejs.sh
skf snippets/biome.json >biome.json

npm init -y
npm pkg set private=true --json
npm pkg set type="module"
npm pkg set scripts.build="tsc"
npm pkg set scripts.start="node ./dist/main.js"
npm pkg set scripts.dev="nodemon src/main.ts"
npm pkg set scripts.test="jest"
npm pkg set scripts.format="biome format --write ."
npm pkg set scripts.lint="biome lint ."
npm pkg set nodemonConfig.execMap.ts="ts-node"

npm install --save-dev $(skf snippets/typescript/devdeps)
npx tsc --init \
    --lib es2023 \
    --module node16 \
    --target es2022 \
    --strict \
    --esModuleInterop \
    --skipLibCheck \
    --moduleResolution node16 \
    --rootDir src/ \
    --outDir dist/
npx ts-jest config:init

npm run format

shskf snippets/direnv/nodejs.sh
direnv allow

shskf snippets/gitignore/nodejs.sh
