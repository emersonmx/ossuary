# snippets

```sh
# render a snippet to a file
cat /path-to-ossuary/python/snippets/a_snippets \
    | skelly input_a=123 input_b=456 input_N=789 \
    >> file_to_append

# append a snippet to a file
cat /path-to-ossuary/python/snippets/a_snippets \
    | skelly input_a=123 input_b=456 input_N=789 \
    > file_to_append

# copy snippet as-is
cp /path-to-ossuary/python/snippets/a_snippet name_of_snippet
```
