/**
 * For a detailed explanation regarding each configuration property, visit:
 * https://jestjs.io/docs/configuration
 */

/** @type {import('jest').Config} */
const config = {
	transform: {
		"^.+\\.(t|j)sx?$": "@swc/jest",
	},
	testPathIgnorePatterns: ["/node_modules/", "/dist/"],
};

export default config;
