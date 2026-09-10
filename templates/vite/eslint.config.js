{% extends "typescript.js" %}

{% block imports %}
import reactHooks from "eslint-plugin-react-hooks";
import reactRefresh from "eslint-plugin-react-refresh";
{%- endblock %}

{% block sourceFiles -%}
["**/*.{js,mjs,cjs,jsx,ts,mts,cts,tsx}"]
{%- endblock %}

{% block extends %}
      reactHooks.configs.flat.recommended,
      reactRefresh.configs.vite,
{%- endblock %}

{% block globals -%}
globals.browser
{%- endblock %}

{% block testFiles -%}
["**/*.spec.{ts,tsx}", "**/*.test.{ts,tsx}"]
{%- endblock %}
