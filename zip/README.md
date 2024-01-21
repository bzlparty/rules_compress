# 7-Zip

## Usage

```starlark
load("@bzlparty_rules_compress//zip:defs.bzl", "gz_compress")

gz_compress(
    name = "archive",
    src = "some_file",
)
```

## Supported Platforms

|         |       amd64        |       arm64        |
| ------- | :----------------: | :----------------: |
| linux   | :white_check_mark: | :white_check_mark: |
| freebsd |        :x:         |        :x:         |
| netbsd  | :white_check_mark: |        :x:         |
| windows |        :x:         |        :x:         |
| darwin  | :white_check_mark: | :white_check_mark: |
