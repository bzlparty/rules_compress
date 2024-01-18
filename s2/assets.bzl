"""S2 Artifacts

https://github.com/klauspost/compress/releases/tag/v1.17.4
"""

load("@bzlparty_tools//lib:platforms.bzl", _PLATFORMS = "PLATFORMS")

ASSETS = {
    "linux_amd64": ("s2-linux_amd64.tar.gz", "sha384-qjydEFa7DGnOkMlXH2xvfk9fnJwd/0nX9lVgg6RlakGFA1Of0y7VetWF0UkYxiZy"),
    "linux_arm64": ("s2-linux_arm64.tar.gz", "sha384-swUKxhNuqswI0K5uca4t8abQo9qUscuKs7PnDcE/kCppCrzxxNbu0LGF8f/+Isq+"),
    "freebsd_amd64": ("s2-freebsd_amd64.tar.gz", "sha384-PykoEFxXdaxpmSvIcYylfKyJuYJLSqaZAzLFV1i00mqUaNum2O+XoTir+FQru0C7"),
    "freebsd_arm64": ("s2-freebsd_arm64.tar.gz", "sha384-aYWD95FUSWJVi5VRnupVSHhRzbytq0SJemKMmGdUhnsIU//C39grt+waevaAi2Vm"),
    "windows_amd64": ("s2-windows_amd64.zip", "sha384-SUhnKlFu/koh1abUJ2pjPog7fxKwueZvYj5/0EtJ9A4Qt+WUZhw0xl2U9YZdqhsO"),
    "windows_arm64": ("s2-windows_arm64.zip", "sha384-xZTNluN4nE/B3WjA2Y/Upv/m+wXfo7SzXKZ6D647HB2BUM1+U3FiXWEt8s/KaCeB"),
    "darwin_amd64": ("s2-darwin_amd64.tar.gz", "sha384-iX7ntPEDjVqUBo1NoOyMADT80tnKczro0zk++z8Y3rMl4s1KNLz6gLbcYLaUv+z1"),
    "darwin_arm64": ("s2-darwin_arm64.tar.gz", "sha384-qRqAq59yVJk30Bq2KccSuf8PaxkYYDjUDwWhn+d3c7QpQO+pfZ7S3WHjG+sVQEh5"),
}

PLATFORMS = {
    p: _PLATFORMS[p]
    for p in ASSETS.keys()
}

VERSION = "1.17.4"
