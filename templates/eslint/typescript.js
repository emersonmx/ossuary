import js from "@eslint/js";
import globals from "globals";
import tseslint from "typescript-eslint";
{%- block imports %}{%- endblock %}
import { defineConfig, globalIgnores } from "eslint/config";

export default defineConfig([
    globalIgnores(["dist"]),
    {
        files: {% block sourceFiles -%}["**/*.{js,mjs,cjs,ts,mts,cts}"]{%- endblock %},
        extends: [
            js.configs.recommended,
            tseslint.configs.strictTypeChecked,
            tseslint.configs.stylisticTypeChecked,
            {%- block extends %}{%- endblock %}
        ],
        languageOptions: {
            globals: {% block globals %}globals.node{%- endblock %},
            parserOptions: {
                projectService: {
                    allowDefaultProject: ["*.config.js"],
                },
            },
        },
    },
    {
        files: {% block testFiles -%}["**/*.spec.ts", "**/*.test.ts"]{%- endblock %},
        rules: {
            "@typescript-eslint/no-unsafe-call": "off",
            "@typescript-eslint/no-unsafe-member-access": "off",
        },
    },
]);
