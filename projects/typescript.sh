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
    $(skf eslint/deps types=yes) \
    $(skf swc/deps jest=yes) \
    $(skf jest/deps types=yes) \
    $(skf prettier/deps) \
    $(skf nodejs/deps) \
    $(skf typescript/deps)

shskf editorconfig/nodejs.sh
skf -l prettier/prettierrc prettier/prettier.config.js >prettier.config.js
skf eslint/typescript.js >eslint.config.js
skf jest/swc-jest.config.js >jest.config.js
pnpm exec tsc \
    --init \
    --types node,jest \
    --noEmit
sed -E \
    -e '\#^\s+//#d' \
    -e 's#/\*.*\*/##g' \
    -e '/^\s*$/d' \
    -i tsconfig.json

shskf direnv/nodejs.sh
direnv allow

mkdir -p src/
cat >src/main.ts <<'EOF'
console.log("Hello World");
EOF

cat >src/main.spec.ts <<'EOF'
test("1 + 1 = 2", () => {
    expect(1 + 1).toBe(2);
});
EOF

pnpm format
