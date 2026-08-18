{% extends "typescript.mjs" %}

{% block imports %}
import reactHooks from "eslint-plugin-react-hooks";
import reactRefresh from "eslint-plugin-react-refresh";
{%- endblock %}

{% block files -%}
["**/*.{js,mjs,cjs,jsx,ts,mts,cts,tsx}"]
{%- endblock %}

{% block extends %}
      reactHooks.configs.flat.recommended,
      reactRefresh.configs.vite,
{%- endblock %}

{% block globals -%}
globals.browser
{%- endblock %}
