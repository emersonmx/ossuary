# yolo

## Setup

```sh
# Setup
cmake -B build -S . -G Ninja -DCMAKE_BUILD_TYPE=Debug

# Build
cmake --build build

# Test
ctest --test-dir build --output-junit build/xunit/results.xml
```
