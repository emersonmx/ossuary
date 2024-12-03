/**
 * @see https://prettier.io/docs/en/configuration.html
 * @type {import("prettier").Config}
 */
const config = {
    trailingComma: "all",
    semi: {{ semi | default(value=true) }},
    singleQuote: false,
};

export default config;
