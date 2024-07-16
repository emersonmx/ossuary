#!/bin/bash

ossuary_path="{{ ossuary_path }}"

skelly -s "${ossuary_path}/javascript/direnv"
skelly -s "${ossuary_path}/javascript/editorconfig"
skelly -s "${ossuary_path}/javascript/prettier"

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

mkdir -p src/
echo 'console.log("Hello World");' >src/main.ts
echo 'test("1 + 1 = 2", () => { expect(1 + 1).toBe(2); });' >src/main.spec.ts

prettier --write .

direnv allow .
