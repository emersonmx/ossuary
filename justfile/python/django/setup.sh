#!/usr/bin/env bash

cat >justfile <<EOF
$(skf justfile/python/sync)

$(skf justfile/python/run command='./manage.py runserver')

$(skf justfile/python/django/make_migrations)

$(skf justfile/python/django/migrate)

$(skf justfile/python/django/add_user)

$(skf justfile/python/django/flush_db)

$(skf justfile/python/django/collect_static)

$(skf justfile/python/format)

$(skf justfile/python/lint)

$(skf justfile/python/test)

$(skf justfile/python/clean)
EOF
