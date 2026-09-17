set quiet

setup-tools:
    ./scripts/setup_tools.sh

reset-tmp:
    mkdir -p tmp
    rm -rf tmp/*

clean:
    rm -rf tmp
