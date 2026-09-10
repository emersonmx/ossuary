#!/usr/bin/env bash
# shellcheck disable=SC2046

shskf gitignore/nodejs.sh

pnpm init
pnpm pkg set \
    name="{{ project_name | default(value="$(basename $PWD)") }}" \
    scripts.build="swc src -d dist" \
    scripts.start="node ./dist/src/main.js" \
    scripts.test="jest" \
    scripts.format="eslint --fix . && prettier --write ." \
    scripts.lint="tsc --noEmit && eslint . && prettier --check ."

pnpm add --save-dev --ignore-scripts \
    $(skf eslint/deps) \
    $(skf swc/deps jest=yes) \
    $(skf jest/deps) \
    $(skf prettier/deps) \
    $(skf nodejs/devdeps)

shskf editorconfig/nodejs.sh
skf -l prettier prettier/prettier.config.js >prettier.config.js
skf eslint/nodejs.js | sed 's/globals: globals.node/globals: { ...globals.node, ...globals.jest }/' >eslint.config.js
skf jest/swc-jest.config.js >jest.config.js

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

pnpm format
