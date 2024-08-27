#!/bin/bash
# shellcheck disable=SC2046

cat >.editorconfig <<EOF
$(skf snippets/editorconfig/base)

$(skf snippets/editorconfig/makefile)

$(skf snippets/editorconfig/markdown)

$(skf snippets/editorconfig/html)

$(skf snippets/editorconfig/yaml)
EOF
skf snippets/prettierrc.json >.prettierrc.json
skf snippets/eslint/nodejs.mjs >eslint.config.mjs

npm init -y
npm pkg set private=true --json
npm pkg set scripts.build="esbuild src/main.js --bundle --outfile=dist/main.js"
npm pkg set scripts.start="node ./dist/main.js"
npm pkg set scripts.dev="nodemon src/main.js"
npm pkg set scripts.test="jest"

npm install --save-dev $(skf snippets/nodejs/devdeps)

npx prettier --write .

cat >.envrc <<EOF
$(skf snippets/direnv/add_to_path path="node_modules/.bin")

$(skf snippets/direnv/dotenv)
EOF
direnv allow .

cat >.gitignore <<EOF
$(curl -L https://www.toptal.com/developers/gitignore/api/node)

.envrc
EOF

rm -f "$0"
