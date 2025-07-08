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
npm pkg set scripts.format="eslint --fix . && prettier --write ."
npm pkg set scripts.lint="eslint . && tsc --noEmit"

npm install --save-dev $(skf typescript/devdeps)

shskf editorconfig/nodejs.sh
skf prettier/prettier.config.mjs >prettier.config.mjs
skf eslint/typescript.mjs >eslint.config.mjs
skf jest/swc-jest.config.mjs >jest.config.mjs
npx tsc --init \
    --target esnext \
    --module nodenext \
    --skipLibCheck \
    --noUncheckedSideEffectImports \
    --resolveJsonModule \
    --strict \
    --exactOptionalPropertyTypes \
    --noFallthroughCasesInSwitch \
    --noImplicitOverride \
    --noImplicitReturns \
    --noPropertyAccessFromIndexSignature \
    --noUncheckedIndexedAccess \
    --erasableSyntaxOnly \
    --verbatimModuleSyntax \
    --noEmit \
    --sourceMap \
    --declaration \
    --declarationMap \
    --isolatedDeclarations
sed -E \
    -e '/^\s+"compilerOptions"/ i\
\  "include": ["src/**/*", "tests/**/*"],' \
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

npm run format
