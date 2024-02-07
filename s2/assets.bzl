"""S2 Artifacts

https://github.com/klauspost/compress/releases/tag/v1.17.6
"""

load("@bzlparty_tools//lib:platforms.bzl", _PLATFORMS = "PLATFORMS")

ASSETS = {
    "linux_amd64": ("s2-linux_amd64.tar.gz", "sha384-PGdcWgxgPYutUXOUHQ6T2j4btinPQYNZZA8D4EOVz82PmpX5xtnKvm3RfbIiAFXt"),
    "linux_arm64": ("s2-linux_arm64.tar.gz", "sha384-2PFXR+4CS7SvU/qmPemAoYmkOp0ty5+s/QlJXRL2DcmoXPl9MOefsQpJjsMngVTx"),
    "freebsd_amd64": ("s2-freebsd_amd64.tar.gz", "sha384-Q1dxZ2F7Vhj5BD4WtXtttkoWFE2io01xWVx6jvF6BziXfnO54ZnSQQ8roEBOkLUB"),
    "freebsd_arm64": ("s2-freebsd_arm64.tar.gz", "sha384-URyYJonZcyGqvDf5imKrDItV/e/JcPNHDCA4Z++n94JXuRE/LrLePEb6Z+L94Wv9"),
    "netbsd_amd64": ("s2-netbsd_amd64.tar.gz", "sha384-CTKmbJMw+SkLwJktxRvZ2dbLbxyFaC1u2s+LMIqTQcJpWsS8R8Ys5rJ3tEgmHDMz"),
    "windows_amd64": ("s2-windows_amd64.zip", "sha384-y8FxLfIH50IAzJdacIIuPMtBmMHg2MQwUV/4yl3SKXzAuVKmFecEdjiyrLvUfNLY"),
    "windows_arm64": ("s2-windows_arm64.zip", "sha384-LuZJP07ZykS7+YF+apoBcK5lX+36tH89DERROZgLTsnIM/uoOGOtEoAgFRwpPcd7"),
    "darwin_amd64": ("s2-darwin_amd64.tar.gz", "sha384-kfcRse+mi6MSs9V99xfe/kA+xgiRHrAlPctYKxgK57pYPcHSq2eZ13AauXPJE0tQ"),
    "darwin_arm64": ("s2-darwin_arm64.tar.gz", "sha384-Oscm+udDWt4qXKTqpuyOVakNfKKYIKSYeNUfG70W80Nfq0G+69nD/gQSCn4Ikj3s"),
}

PLATFORMS = {
    p: _PLATFORMS[p]
    for p in ASSETS.keys()
}

VERSION = "1.17.6"
