"S2 Public API"

load("//s2/private:s2.bzl", _S2FileInfo = "S2FileInfo", _s2c = "s2c")

S2FileInfo = _S2FileInfo

s2c = _s2c

def s2_compress(name, out = None, **kwargs):
    """Macro around s2c rule

    Args:
      name: Name of the target
      out: Name of the output file
      **kwargs: All other args of s2c
    """
    if not out:
        out = "%s.%s" % (name, "sz" if kwargs.get("snappy") else "s2")

    _s2c(
        name = name,
        out = out,
        **kwargs
    )
