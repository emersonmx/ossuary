#!/bin/bash

sks javascript/direnv
sks javascript/editorconfig
sks javascript/prettier

npm init -y

npm pkg set private=true --json
npm pkg set scripts.build="tsc"
npm pkg set scripts.start="node ./build/main.js"
npm pkg set scripts.test="jest"

npm install --save-dev typescript @types/node jest ts-jest @types/jest

curl "https://raw.githubusercontent.com/tsconfig/bases/main/bases/node-lts.json" |
    jq 'pick(.compilerOptions)
        | .compilerOptions.rootDir="src/"
        | .compilerOptions.outDir="build/"' >tsconfig.json
npx ts-jest config:init

mkdir -p src/
echo 'console.log("Hello World");' >src/main.ts

prettier --write .

direnv allow .
