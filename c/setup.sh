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

cat >README.md <<'EOF'
# yolo

## Setup

```sh
# Setup
cmake -B build -S . -G Ninja -DCMAKE_BUILD_TYPE=Debug

# Build
cmake --build build

# Test
ctest --test-dir build/tests --output-junit xunit/results.xml
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

cat >tests/test_example.c <<'EOF'
#include <unity.h>

void setUp(void)
{
}

void tearDown(void)
{
}

void test_example()
{
    TEST_ASSERT_EQUAL_INT32(4, 2 + 2);
}

int main()
{
    UNITY_BEGIN();
    RUN_TEST(test_example);
    return UNITY_END();
}
EOF
