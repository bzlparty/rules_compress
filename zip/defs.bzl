"Zip Public API"

load("//zip/private:zip.bzl", _zip = "zip")

zip = _zip

def gz_compress(name, src, out = None, **kwargs):
    """Macro around zip rule to compress with gzip

    Args:
      name: Name of the target
      src: Label of the input
      out: Name of the output file
      **kwargs: All other args of zip
    """
    _zip(
        name = name,
        out = out or "%s.gz" % name,
        srcs = [src],
        **kwargs
    )
