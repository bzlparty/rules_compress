# Bazel Rules for File Compression

[![Test](https://github.com/bzlparty/rules_compress/actions/workflows/test.yaml/badge.svg?branch=main&event=push)](https://github.com/bzlparty/rules_compress/actions/workflows/test.yaml)

## Installation

See install instructions on the [release page](https://github.com/bzlparty/rules_compress/releases).

## Usage

### S2

```
load("@bzlparty_rules_compress//s2:defs.bzl", "s2_compress")

s2_compress(
    name = "archive",
    src = ":some_file",
    out = "some_archive.s2",
)
```

## Development

Install git hooks:

```bash
pre-commit install
```

## License

[GNU GPL 3.0](/LICENSE)
