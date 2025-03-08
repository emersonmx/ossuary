#!/bin/bash
# shellcheck disable=SC2046

shskf editorconfig/nodejs.sh
skf biome/biome.json >biome.json

npm init -y
npm pkg set private=true --json
npm pkg set type="module"
npm pkg set scripts.build="tsc"
npm pkg set scripts.start="node ./dist/main.js"
npm pkg set scripts.dev="nodemon src/main.ts"
npm pkg set scripts.test="jest"
npm pkg set scripts.format="biome check --write ."
npm pkg set scripts.lint="biome check ."
npm pkg set nodemonConfig.execMap.ts="ts-node"

npm install --save-dev $(skf typescript/devdeps)
npx tsc --init \
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

npm run format

shskf direnv/nodejs.sh
direnv allow

shskf gitignore/nodejs.sh

mkdir -p src/
cat >src/main.ts <<'EOF'
console.log("Hello World");
EOF

cat >src/main.spec.ts <<'EOF'
test("1 + 1 = 2", () => {
    expect(1 + 1).toBe(2);
});
EOF
