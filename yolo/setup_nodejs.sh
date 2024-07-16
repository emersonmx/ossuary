#!/bin/bash

sks javascript/direnv
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

mkdir -p src/
echo 'console.log("Hello World");' >src/main.js
echo 'test("1 + 1 = 2", () => { expect(1 + 1).toBe(2); });' >src/main.spec.js

prettier --write .

direnv allow .
