#!/bin/bash
# shellcheck disable=SC2046

git init
shskf gitignore/nodejs.sh

npm init -y
npm pkg set private=true --json
npm pkg set type="module"
npm pkg set scripts.build="swc src -d dist"
npm pkg set scripts.start="node ./dist/src/main.js"
npm pkg set scripts.test="jest"
npm pkg set scripts.format="biome check --write ."
npm pkg set scripts.lint="biome check ."

npm install --save-dev $(skf nodejs/devdeps)

shskf editorconfig/nodejs.sh
skf biome/biome.json >biome.json
skf jest/swc-jest.config.mjs >jest.config.mjs

shskf direnv/nodejs.sh
direnv allow

mkdir -p src/
cat >src/main.js <<'EOF'
console.log("Hello World");
EOF

cat >src/main.spec.js <<'EOF'
test("1 + 1 = 2", () => {
    expect(1 + 1).toBe(2);
});
EOF

npm run format
