#!/bin/bash
# shellcheck disable=SC2046

git init
shskf gitignore/python.sh

uv init
uv add --upgrade --dev $(skf python/devdeps)

shskf editorconfig/python.sh
shskf pre-commit/python.sh

shskf direnv/python.sh
direnv allow

cat >main.py <<'EOF'
def main() -> int:
    print("Hello World")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
EOF

mkdir -p test/
cat >test/example_test.py <<'EOF'
def test_example():
    assert 1 + 1 == 2
EOF
