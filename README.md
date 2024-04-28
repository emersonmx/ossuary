# ossuary

## skeletons

```sh
skelly -s /path-to-ossuary/a-language/skelenton \
    input_a=123 input_b=456 input_N=789
```

## snippets

```sh
# render a snippet to a file
skelly -f /path-to-ossuary/a-language/snippets/a_snippets \
    input_a=123 input_b=456 input_N=789 \
    > a_file

# append a snippet to a file
skelly -f /path-to-ossuary/a-language/snippets/a_snippets \
    input_a=123 input_b=456 input_N=789 \
    >> file_to_append
```
