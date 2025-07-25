#!/bin/bash

git init
shskf gitignore/c.sh

shskf editorconfig/c.sh
skf clang-format/default >.clang-format

echo "CC=clang" >.env
skf direnv/dotenv >.envrc
direnv allow

project_name=$(basename "$PWD")
mkdir -p src/ tests/
skf cmake/base project_name="$project_name" >CMakeLists.txt
skf cmake/src project_name="$project_name" >src/CMakeLists.txt
skf cmake/tests >tests/CMakeLists.txt

skf justfile/c binary_path="build/src/${project_name}" >justfile

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

cat >src/main.c <<'EOF'
#include <stdio.h>

int main()
{
    printf("Hello World!\n");
    return 0;
}
EOF

cat >tests/example_test.c <<'EOF'
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
