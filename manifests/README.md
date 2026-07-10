# Package manifests

The public manifest is organised by capability rather than assuming macOS and
Ubuntu package names are identical.

- `Brewfile` is the macOS implementation.
- `apt/common.txt` is the shared Ubuntu base.
- `apt/<profile>.txt` contains additive profile packages.

Keep runtime and pinned CLI versions, including Neovim, in `../mise.toml`, not in either OS package manifest.
Packages used only by MaxMind belong in the private overlay.

Ubuntu bootstrap enables the Git Core PPA before installing the manifests so
the declared `git` package resolves to the current stable Git release.

Tree-sitter CLI is pinned in `../mise.toml` so parser installation uses a
current, consistent version on Ubuntu and macOS.
