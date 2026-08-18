set quiet

setup:
    ./scripts/setup.sh

reset-tmp:
    mkdir -p tmp
    rm -rf tmp/{*,.*}

clean:
    rm -rf tmp
