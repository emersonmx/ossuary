BIN_NAME := $(shell basename $(PWD))
BUILD_DIR := build
TARGET_PATH := $(BUILD_DIR)/$(BIN_NAME)
SRC_DIRS := src
SRCS := $(shell find $(SRC_DIRS) -name '*.c' )

.PHONY: run
run: build
	$(TARGET_PATH)

.PHONY: build
build:
	mkdir -p $(BUILD_DIR)
	$(CC) -o $(TARGET_PATH) $(SRCS)

.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)
