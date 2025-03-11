import pluginJs from "@eslint/js";
import eslintConfigPrettier from "eslint-config-prettier/flat";
import globals from "globals";

/** @type {import('eslint').Linter.Config[]} */
export default [
	{ languageOptions: { globals: { ...globals.node } } },
	pluginJs.configs.recommended,
	eslintConfigPrettier,
];
