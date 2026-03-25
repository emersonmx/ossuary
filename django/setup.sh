#!/usr/bin/env bash
# shellcheck disable=SC2046

{% if project_name is matching("[^0-9a-zA-Z_]") -%}
echo "Project name must only contain letters, numbers, and underscores."
exit 1
{%- else -%}

git init
shskf gitignore/python.sh

uv init
uv add --upgrade $(skf django/deps)
uv add --upgrade --dev $(skf python/devdeps) $(skf django/devdeps)

shskf editorconfig/django.sh
shskf justfile/python/django/setup.sh >justfile

shskf direnv/python.sh
direnv allow

# add files
mkdir -p {{ project_name }}
skf django/manage.py >manage.py project_name={{ project_name }}
chmod +x manage.py
skf django/env.example >.env project_name={{ project_name }}
skf django/asgi.py >{{project_name}}/asgi.py project_name={{ project_name }}
skf django/settings.py >{{project_name}}/settings.py project_name={{ project_name }}
skf django/urls.py >{{project_name}}/urls.py project_name={{ project_name }}
skf django/wsgi.py >{{project_name}}/wsgi.py project_name={{ project_name }}

just format

{%- endif %}
