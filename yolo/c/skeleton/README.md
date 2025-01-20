# yolo

## Setup

```sh
# Setup
cmake -B build -S . -G Ninja

# Build
cmake --build build

# Test
ctest --test-dir build --output-junit build/xunit/results.xml
```
