# zip

## Usage

```starlark
load("@bzlparty_rules_compress//zip:defz.bzl", "gz_compress")

gz_compress(
    name = "archive",
    src = "some_file",
    out = "some_file.gz",
)
```

## Supported Platforms

|         | amd64 | arm64 |
| ------- | :---: | :---: |
| linux   |   1   |   1   |
| freebsd |   0   |   0   |
| windows |   0   |   0   |
| darwin  |   1   |   1   |
