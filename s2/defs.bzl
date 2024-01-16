"S2 Public API"

load(":s2_compress.bzl", _S2FileInfo = "S2FileInfo", _s2_compress = "s2_compress")
load(":toolchain.bzl", _S2Info = "S2Info")

S2Info = _S2Info
S2FileInfo = _S2FileInfo

def s2_compress(name, out = None, **kwargs):
    """Macro around s2_compress rule

    name: Name of the target
    out: Name of the output file
    **kwargs: All other args of s2_compress

    """
    if not out:
        out = "%s.%s" % (name, "sz" if kwargs.get("snappy") else "s2")

    _s2_compress(
        name = name,
        out = out,
        **kwargs
    )
