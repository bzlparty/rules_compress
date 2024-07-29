"Public API"

load("//compress/private:s2.bzl", _S2FileInfo = "S2FileInfo", _s2c = "s2c")
load("//compress/private:zip.bzl", _zip = "zip")

S2FileInfo = _S2FileInfo

s2c = _s2c
zip = _zip

def s2_compress(name, out = None, **kwargs):
    """Macro around s2c rule

    Args:
      name: Name of the target
      out: Name of the output file
      **kwargs: All other args of [s2c](#s2c)
    """
    if not out:
        out = "%s.%s" % (name, "sz" if kwargs.get("snappy") else "s2")

    _s2c(
        name = name,
        out = out,
        **kwargs
    )

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
