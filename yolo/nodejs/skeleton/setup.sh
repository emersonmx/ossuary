#!/bin/bash
# shellcheck disable=SC2046

bash <(skf yolo/snippets/editorconfig/nodejs)
skf snippets/biome.json >biome.json

npm init -y
npm pkg set private=true --json
npm pkg set type="module"
npm pkg set scripts.build="esbuild src/main.js --bundle --outfile=dist/main.js"
npm pkg set scripts.start="node ./dist/main.js"
npm pkg set scripts.dev="nodemon src/main.js"
npm pkg set scripts.test="jest"
npm pkg set scripts.format="biome check --write ."
npm pkg set scripts.lint="biome lint ."

npm install --save-dev $(skf snippets/nodejs/devdeps)

npx @biomejs/biome format --write .

bash <(skf yolo/snippets/direnv/nodejs)
direnv allow

bash <(skf yolo/snippets/gitignore/nodejs)

rm -f "$0"
