#!/bin/bash
# shellcheck disable=SC2046

shskf snippets/editorconfig/nodejs.sh
skf snippets/biome.json >biome.json

npm init -y
npm pkg set private=true --json
npm pkg set type="module"
npm pkg set scripts.build="esbuild src/main.js --bundle --outfile=dist/main.js"
npm pkg set scripts.start="node ./dist/main.js"
npm pkg set scripts.dev="nodemon src/main.js"
npm pkg set scripts.test="jest"
npm pkg set scripts.format="biome format --write ."
npm pkg set scripts.lint="biome lint ."

npm install --save-dev $(skf snippets/nodejs/devdeps)

npm run format

shskf snippets/direnv/nodejs.sh
direnv allow

shskf snippets/gitignore/nodejs.sh
