set quiet

setup:
    ./scripts/setup_tools.sh
    ./scripts/setup_completions.sh

reset-tmp:
    mkdir -p tmp
    rm -rf tmp/*

clean:
    rm -rf tmp
