CC={{ cc }}

.PHONY: run
run: build
	./main

.PHONY: build
build:
	${CC} -o main ./src/main.c

.PHONY: clean
clean:
	rm -f main
