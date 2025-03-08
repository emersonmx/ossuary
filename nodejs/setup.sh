#!/bin/bash
# shellcheck disable=SC2046

shskf editorconfig/nodejs.sh
skf biome/biome.json >biome.json

npm init -y
npm pkg set private=true --json
npm pkg set type="module"
npm pkg set scripts.build="esbuild src/main.js --bundle --outfile=dist/main.js"
npm pkg set scripts.start="node ./dist/main.js"
npm pkg set scripts.dev="nodemon src/main.js"
npm pkg set scripts.test="jest"
npm pkg set scripts.format="biome format --write ."
npm pkg set scripts.lint="biome lint ."

npm install --save-dev $(skf nodejs/devdeps)

npm run format

shskf direnv/nodejs.sh
direnv allow

shskf gitignore/nodejs.sh
