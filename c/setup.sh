#!/bin/bash

skf snippets/clang-format >.clang-format

shskf snippets/editorconfig/c.sh

project_name=$(basename "$PWD")
mkdir -p src/ tests/
skf snippets/cmake/base project_name="$project_name" >CMakeLists.txt
skf snippets/cmake/src project_name="$project_name" >src/CMakeLists.txt
skf snippets/cmake/tests >tests/CMakeLists.txt

echo "CC=clang" >.env
skf snippets/direnv/dotenv >.envrc
direnv allow

shskf snippets/gitignore/c.sh

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
