#!/usr/bin/env bash
# shellcheck disable=SC2046

shskf gitignore/nodejs.sh

pnpm init
pnpm pkg set \
    name="{{ project_name | default(value="$(basename $PWD)") }}" \
    scripts.build="tsc --build && vite build" \
    scripts.dev="vite" \
    scripts.preview="vite preview" \
    scripts.test="jest" \
    scripts.format="eslint --fix . && prettier --write ." \
    scripts.lint="tsc --noEmit && eslint . && prettier --check ."

pnpm add $(skf vite/deps)
pnpm add --save-dev --ignore-scripts \
    $(skf eslint/deps types=yes) \
    $(skf jest/deps types=yes) \
    $(skf prettier/deps tailwindcss=yes) \
    $(skf nodejs/devdeps) \
    $(skf typescript/devdeps) \
    $(skf vite/devdeps)

shskf editorconfig/nodejs.sh
skf -l prettier prettier/prettier.config.js tailwindcss=yes >prettier.config.js
skf -l eslint vite/eslint.config.js >eslint.config.js

shskf direnv/nodejs.sh
direnv allow

cat >tsconfig.json <<'EOF'
{
  "files": [],
  "references": [
    { "path": "./tsconfig.app.json" },
    { "path": "./tsconfig.node.json" }
  ]
}
EOF

cat >tsconfig.app.json <<'EOF'
{
  "compilerOptions": {
    "tsBuildInfoFile": "./node_modules/.tmp/tsconfig.app.tsbuildinfo",
    "target": "es2023",
    "lib": ["ES2023", "DOM"],
    "module": "esnext",
    "types": ["vite/client"],
    "allowArbitraryExtensions": true,
    "skipLibCheck": true,

    /* Bundler mode */
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true,
    "verbatimModuleSyntax": true,
    "moduleDetection": "force",
    "noEmit": true,
    "jsx": "react-jsx",

    /* Linting */
    "strict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "erasableSyntaxOnly": true,
    "noFallthroughCasesInSwitch": true
  },
  "include": ["src"]
}
EOF

cat >tsconfig.node.json <<'EOF'
{
  "compilerOptions": {
    "tsBuildInfoFile": "./node_modules/.tmp/tsconfig.node.tsbuildinfo",
    "target": "es2023",
    "lib": ["ES2023"],
    "types": ["node"],
    "skipLibCheck": true,

    /* Bundler mode */
    "module": "nodenext",
    "allowImportingTsExtensions": true,
    "verbatimModuleSyntax": true,
    "moduleDetection": "force",
    "noEmit": true,

    /* Linting */
    "strict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "erasableSyntaxOnly": true,
    "noFallthroughCasesInSwitch": true
  },
  "include": ["vite.config.ts"]
}
EOF

cat >vite.config.ts <<'EOF'
import { defineConfig } from "vite";
import tailwindcss from "@tailwindcss/vite";
import react from "@vitejs/plugin-react";

// https://vite.dev/config/
export default defineConfig({
  plugins: [tailwindcss(), react()],
});
EOF

cat >index.html <<'EOF'
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>{{ project_name }}</title>
  </head>
  <body>
    <div id="root"></div>
    <script type="module" src="/src/main.tsx"></script>
  </body>
</html>
EOF

mkdir -p src/
cat >src/main.tsx <<'EOF'
import { StrictMode } from "react";
import { createRoot } from "react-dom/client";
import "./index.css";
import App from "./App.tsx";

const container = document.getElementById("root");
if (!container) throw new Error("Root container not found");

createRoot(container).render(
  <StrictMode>
    <App />
  </StrictMode>,
);
EOF

cat >src/index.css <<'EOF'
@import "tailwindcss";
EOF

cat >src/App.tsx <<'EOF'
import { useState } from "react";

function App() {
  const [count, setCount] = useState(0);

  return (
    <>
      <section className="flex min-h-screen flex-col items-center justify-center bg-gray-100">
        <button
          type="button"
          className="rounded bg-blue-500 px-4 py-2 font-bold text-white hover:bg-blue-700"
          onClick={() => setCount((count) => count + 1)}
        >
          Count is {count}
        </button>
      </section>
    </>
  );
}

export default App;
EOF

pnpm format
