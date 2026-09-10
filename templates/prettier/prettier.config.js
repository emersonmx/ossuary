{% extends "prettierrc" %}

{%- block config -%}
/**
 * @see https://prettier.io/docs/en/configuration.html
 * @type {import("prettier").Config}
 */
const config = {{ super() }};

export default config;
{%- endblock %}
