# ossuary

A collection of templates for [skelly](https://github.com/emersonmx/skelly), a
scaffold tool that renders [Tera](https://keats.github.io/tera/) templates.

ossuary holds two kinds of things:

- **templates** (`templates/`): config files, snippets and small setup scripts
  grouped by tool (`gitignore`, `editorconfig`, `justfile`, `rustfmt`,
  `githooks`, `eslint`, `typescript`, ...).
- **projects** (`projects/`): shell scripts that bootstrap a whole project
  (`rust-bin`, `rust-lib`, `rust-workspace`, `bevy`, `python`, `django`,
  `typescript`, `c`, `golang`, `godot`) by combining templates.

## Requirements

- `skelly` (`cargo install --git https://github.com/emersonmx/skelly`)
- `bash` and `just`
- the toolchain of each project you generate (`cargo`, `python3`, `node`,
  `direnv`, ...)

## Setup

```sh
just setup
```

This links the helper tools from `scripts/tools` into `~/.local/bin` and their
zsh completions into `~/.cache/zsh/completions`. Make sure both are in your
`PATH` and `fpath`.

## Tools

Template paths are relative to `templates/`; project names are the file names
in `projects/` without `.sh`.

| Tool    | Description                                                      |
| ------- | ---------------------------------------------------------------- |
| `sk`    | Alias for `skelly`.                                              |
| `skf`   | Render a template to stdout.                                     |
| `shskf` | Render a shell template and run it with `sh`.                    |
| `skp`   | Render a project script and run it in the current directory.     |
| `skfls` | List available templates (skips paths starting with `.` or `_`). |
| `skpls` | List available projects.                                         |

### Render a template

```sh
# print to stdout
skf gitignore/nodejs.sh

# write or append to a file
skf direnv/dotenv >.envrc
skf editorconfig/yaml >>.editorconfig
```

Inputs are passed as `KEY=value` pairs:

```sh
skf python/pyproject.toml name=my-app requires_python=3.13 >pyproject.toml
```

### Use libraries

Templates can include or extend other templates passed as libraries with `-l`.
A library is referenced by its path relative to `templates/`:

```sh
skf -l eslint/typescript.js vite/eslint.config.js >eslint.config.js
```

### Run a setup script

Templates ending in `.sh` are setup scripts. `shskf` renders and runs them:

```sh
shskf rustfmt/setup.sh
shskf githooks/setup.sh pre_commit=rust/pre-commit
```

### Bootstrap a project

```sh
mkdir my-app && cd my-app
skp rust-bin
```

Project scripts are templates too, so they accept inputs:

```sh
skp python project_name=my-app
```

## Using skelly directly

The tools are thin wrappers around `skelly`, which can also be called with
absolute paths:

```sh
# render a file
skelly -f /path-to-ossuary/templates/gitignore/rust.sh

# render a file with a library
skelly -l /path-to-ossuary/templates/eslint/typescript.js \
    -f /path-to-ossuary/templates/vite/eslint.config.js

# scaffold a skeleton directory (with skelly.toml and skeleton/)
skelly -s /path-to-skeleton -o output-dir input_a=123 input_b=456
```

See `skelly --help` for all options.

## Layout

```
projects/        project bootstrap scripts (used by skp)
scripts/         setup scripts (used by just setup)
scripts/tools/   helper tools and their zsh completions
templates/       templates grouped by tool
```

## Development

```sh
just reset-tmp   # create or empty tmp/ to try templates in
just clean       # remove tmp/
```
