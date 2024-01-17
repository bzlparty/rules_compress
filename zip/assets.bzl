"""Assets

https://github.com/ip7z/7zip/releases/tag/23.01
"""

load("@bzlparty_tools//lib:platforms.bzl", _PLATFORMS = "PLATFORMS")

ASSETS = {
    "linux_amd64": ("7z2301-linux-x64.tar.xz", "sha384-vUHAT60cQrz9f9Io4B39G7gFHIeFvB0AGIgvYMei9KMExVwkG1ddKtRHP5kpj6xH"),
    "linux_arm64": ("7z2301-linux-arm64.tar.xz", "sha384-P4ozAhVa9VwHwQNtnuXbhHifw6v4432u8JU31cLATiuudGROJLSV85y1lBc2SMdy"),
    "darwin_amd64": ("7z2301-mac.tar.xz", "sha384-FGuZ8xXzwK4LJKG11XCwCm0pIw/W10fJFqHvDOkJPATGSemjthTe0J4MgwHforcc"),
    "darwin_arm64": ("7z2301-mac.tar.xz", "sha384-FGuZ8xXzwK4LJKG11XCwCm0pIw/W10fJFqHvDOkJPATGSemjthTe0J4MgwHforcc"),
}

PLATFORMS = {
    p: _PLATFORMS[p]
    for p in ASSETS.keys()
}

VERSION = "23.01"
