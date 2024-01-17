"Zip Public API"

load(":zip.bzl", _zip = "zip")

zip = _zip

def gz_compress(name, src, out = None, **kwargs):
    _zip(
        name = name,
        out = out or "%s.gz" % name,
        srcs = [src],
        **kwargs
    )
