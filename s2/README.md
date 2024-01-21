# S2

## Usage

```starlark
load("@bzlparty_rules_compress//s2:defs.bzl", "s2_compress")

s2_compress(
    name = "archive",
    src = "some_file",
    out = "some_file.s2",
)
```

## Supported Platforms

|         |       amd64        |       arm64        |
| ------- | :----------------: | :----------------: |
| linux   | :white_check_mark: | :white_check_mark: |
| freebsd | :white_check_mark: | :white_check_mark: |
| netbsd  | :white_check_mark: |        :x:         |
| windows | :white_check_mark: | :white_check_mark: |
| darwin  | :white_check_mark: | :white_check_mark: |
