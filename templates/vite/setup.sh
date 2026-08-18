#!/usr/bin/env bash
# shellcheck disable=SC2046

shskf gitignore/nodejs.sh

npm init -y \
    --init-private \
    --init-type module \
    --init-license MIT
npm pkg set name="{{ project_name }}"
npm pkg set scripts.build="tsc --build && vite build"
npm pkg set scripts.dev="vite"
npm pkg set scripts.preview="vite preview"
npm pkg set scripts.test="jest"
npm pkg set scripts.format="eslint --fix . && prettier --write ."
npm pkg set scripts.lint="tsc --noEmit && eslint . && prettier --check ."

npm install --save $(skf vite/deps)
npm install --save-dev \
    $(skf eslint/deps types=yes) \
    $(skf jest/deps types=yes) \
    $(skf prettier/deps tailwindcss=yes) \
    $(skf nodejs/devdeps) \
    $(skf typescript/devdeps) \
    $(skf vite/devdeps)

shskf editorconfig/nodejs.sh
skf prettier/prettier.config.mjs tailwindcss=yes >prettier.config.mjs
skf -l eslint vite/eslint.config.mjs >eslint.config.mjs

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

npm run format
