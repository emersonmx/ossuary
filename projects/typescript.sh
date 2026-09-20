#!/usr/bin/env bash

set -euo pipefail

git init
shskf gitignore/nodejs.sh

skf nodejs/package.json \
    name="{{ project_name | default(value="$(basename $PWD)") }}" \
    build_script="tsc" \
    start_script="node dist/src/main.js" \
    test_script="vitest run" \
    format_script="oxlint --fix . && prettier --write ." \
    lint_script="tsc --noEmit && oxlint . && prettier --check ." \
    devdeps="$(
        (
            skf oxlint/deps
            skf vitest/deps
            skf prettier/deps
            skf typescript/deps
        ) | tr '\n' ','
    )" \
    >package.json

pnpm update --latest

shskf editorconfig/nodejs.sh
skf prettier/prettierrc >.prettierrc
skf oxlint/oxlintrc.json >.oxlintrc.json
skf vitest/vitest.config.js >vitest.config.js

pnpx --package typescript tsc \
    --init \
    --rootDir . \
    --outDir dist \
    --types node,vitest/globals
sed -E \
    -e '\#^\s+//#d' \
    -e 's#/\*.*\*/##g' \
    -e '/^\s*$/d' \
    -e 's/^  \}$/  },/' \
    -e '/^  \},$/a\  "include": ["src/"],' \
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
