#!/bin/bash

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

tsc --init \
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

prettier --write .

cat >.envrc <<EOF
$(skf snippets/direnv/add_to_path path="node_modules/.bin")

$(skf snippets/direnv/dotenv)
EOF
direnv allow .
