# Bazel Rules for File Compression

[![Test](https://github.com/bzlparty/rules_compress/actions/workflows/test.yaml/badge.svg?branch=main&event=push)](https://github.com/bzlparty/rules_compress/actions/workflows/test.yaml)
[![Release](https://img.shields.io/github/v/release/klauspost/compress?label=Release)](https://github.com/bzlparty/rules_compress/releases/latest)

## Installation

> [!NOTE]  
> Releases are not yet published to BCR!

See install instructions on the [release page](https://github.com/bzlparty/rules_compress/releases/latest).

## Compression

### [S2](https://github.com/klauspost/compress/tree/master/s2#s2-compression)

> S2 is a high performance replacement for Snappy.

- [**Details**](/s2/README.md)
- [**Rules**](/s2/docs/rules.md)
- [**Binaries**](https://github.com/klauspost/compress/releases)

### [7-Zip](https://www.7-zip.org/)

> 7-Zip is a file archiver with a high compression ratio.

- [**Details**](/zip/README.md)
- [**Rules**](/zip/docs/rules.md)
- [**Binaries**](https://github.com/ip7z/7zip/releases)

## Development

Install git hooks:

```bash
pre-commit install
```

## License

[GNU GPL 3.0](/LICENSE)
