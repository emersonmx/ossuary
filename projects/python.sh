#!/usr/bin/env bash
# shellcheck disable=SC2046

set -euo pipefail

git init
shskf gitignore/python.sh

python_version=$(python3 -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')
skf python/pyproject.toml \
    name="{{ project_name | default(value="$(basename $PWD)") }}" \
    requires_python="$python_version" \
    devdeps="$(skf python/devdeps | tr '\n' ',')" \
    >pyproject.toml

shskf editorconfig/python.sh
shskf justfile/python/setup.sh >justfile

shskf direnv/python.sh
direnv allow

cat >main.py <<'EOF'
def say() -> str:
    return "Hello World"


def main() -> int:
    say()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
EOF

cat >main_test.py <<'EOF'
from main import say


def test_say():
    assert say() == "Hello World"
EOF

just format
