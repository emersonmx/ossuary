#!/bin/bash
# shellcheck disable=SC2046

shskf snippets/editorconfig/python.sh

shskf snippets/pre-commit/python.sh

uv init
uv add --upgrade --dev $(skf snippets/python/devdeps)

shskf snippets/direnv/python.sh
direnv allow

shskf snippets/gitignore/python.sh

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
