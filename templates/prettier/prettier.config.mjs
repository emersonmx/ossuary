{%- set plugins = [] -%}

{%- if tailwindcss and tailwindcss == "yes" -%}
{%- set plugins = [...plugins, "prettier-plugin-tailwindcss"] -%}
{%- endif -%}

/**
 * @see https://prettier.io/docs/en/configuration.html
 * @type {import("prettier").Config}
 */
const config = {
  trailingComma: "all",
  semi: {{ semi | default(value=true) }},
  singleQuote: false,
  {%- if plugins | length > 0 %}
  plugins: {{ plugins | json_encode }},
  {%- endif %}
};

export default config;
