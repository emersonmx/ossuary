#!/bin/bash

git init
shskf gitignore/c.sh

shskf editorconfig/c.sh
skf clang-format/default >.clang-format

echo "CC=clang" >.env
skf direnv/dotenv >.envrc
direnv allow

project_name=$(basename "$PWD")
cat >CMakeLists.txt <<EOF
$(skf cmake/c_base project_name="$project_name")

$(skf cmake/src binary_name="$project_name")

$(skf cmake/tests)
EOF

skf justfile/c binary_path="build/${project_name}" >justfile

echo "# ${project_name}" >README.md
cat >>README.md <<'EOF'

## Setup

```sh
# Setup
just setup Debug

# Build
just build

# Test
just test

# Format
just format

# Clean
just clean
```
EOF

cat >main.c <<'EOF'
#include <stdio.h>

int main()
{
    printf("Hello World!\n");
    return 0;
}
EOF

cat >example_test.c <<'EOF'
#include <unity.h>

void setUp(void)
{
}

void tearDown(void)
{
}

void example_test()
{
    TEST_ASSERT_EQUAL_INT32(4, 2 + 2);
}

int main()
{
    UNITY_BEGIN();
    RUN_TEST(example_test);
    return UNITY_END();
}
EOF

just format
