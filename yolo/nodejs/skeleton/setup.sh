#!/bin/bash

sks javascript/editorconfig
sks javascript/prettier

npm init -y
npm pkg set private=true --json
npm pkg set scripts.build="esbuild src/main.js --bundle --outfile=dist/main.js"
npm pkg set scripts.start="node ./dist/main.js"
npm pkg set scripts.dev="nodemon src/main.js"
npm pkg set scripts.test="jest"

npm install --save-dev \
    esbuild \
    nodemon \
    jest

prettier --write .

cat >.envrc <<EOF
$(skf snippets/direnv/add_to_path path="node_modules/.bin")

$(skf snippets/direnv/dotenv)
EOF
direnv allow .
