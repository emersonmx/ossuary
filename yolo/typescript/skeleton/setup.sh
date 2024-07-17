#!/bin/bash

sks javascript/direnv
sks javascript/editorconfig
sks javascript/prettier

npm init -y
npm pkg set private=true --json
npm pkg set scripts.build="tsc"
npm pkg set scripts.start="node ./dist/main.js"
npm pkg set scripts.test="jest"

npm install --save-dev \
    typescript \
    @types/node \
    jest \
    ts-jest \
    @types/jest

curl "https://raw.githubusercontent.com/tsconfig/bases/main/bases/node-lts.json" |
    npx strip-json-comments-cli |
    jq 'pick(.compilerOptions)
        | .compilerOptions.rootDir="src/"
        | .compilerOptions.outDir="dist/"
        ' >tsconfig.json
npx ts-jest config:init

prettier --write .

direnv allow .
