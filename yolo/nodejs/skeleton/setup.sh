#!/bin/bash

sks javascript/direnv
echo "" >>.envrc
skf snippets/base_envrc >>.envrc
sks javascript/editorconfig
sks javascript/prettier

npm init -y
npm pkg set private=true --json
npm pkg set scripts.build="esbuild src/main.js --bundle --outfile=dist/main.js"
npm pkg set scripts.start="node ./dist/main.js"
npm pkg set scripts.test="jest"

npm install --save-dev \
    esbuild \
    jest

prettier --write .

direnv allow .
