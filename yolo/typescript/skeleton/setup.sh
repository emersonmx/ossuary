#!/bin/bash
# shellcheck disable=SC2046

cat >.editorconfig <<EOF
$(skf snippets/editorconfig/base)

$(skf snippets/editorconfig/makefile)

$(skf snippets/editorconfig/markdown)

$(skf snippets/editorconfig/html)

$(skf snippets/editorconfig/yaml)
EOF
skf snippets/biome.json >biome.json

npm init -y
npm pkg set private=true --json
npm pkg set type="module"
npm pkg set scripts.build="tsc"
npm pkg set scripts.start="node ./dist/main.js"
npm pkg set scripts.dev="nodemon src/main.ts"
npm pkg set scripts.test="jest"
npm pkg set scripts.format="biome check --write ."
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

npx @biomejs/biome format --write .

cat >.envrc <<EOF
$(skf snippets/direnv/add_to_path path="node_modules/.bin")

$(skf snippets/direnv/dotenv)
EOF
direnv allow .

cat >.gitignore <<EOF
$(curl -L https://www.toptal.com/developers/gitignore/api/node)

.envrc
EOF

rm -f "$0"
