# Dotfiles

Cross-platform workstation configuration for Apple Silicon macOS and native
Ubuntu (x86_64 and arm64). The public repository is a chezmoi source; a
separate private repository provides encrypted secrets and work-specific
overlays.

## Bootstrap

On a new machine, clone this repository and run:

```sh
git clone https://github.com/kevcenteno/dotfiles.git ~/.local/share/dotfiles
cd ~/.local/share/dotfiles
./bootstrap
```

Bootstrap asks for a `personal`, `work`, or `devbox` profile. It installs the
required package manager and packages, configures chezmoi, makes a timestamped
backup before the first replacement, applies the public source, installs the
private overlay, and changes the login shell to Zsh.

`work` is a generic public profile. Its MaxMind-specific packages, Git
identity, hosts, and configuration belong only in the private overlay.

`devbox` is an Ubuntu-only headless personal-development profile.

## Daily use

`mise` exposes the normal maintenance commands:

```sh
mise run diff
mise run apply
mise run update-config
mise run update-packages
mise run update-runtimes
mise run check
```

The source repositories are authoritative. Edit a source file, inspect the
diff, then commit and push. Normal `chezmoi apply` only manages files; it does
not install packages or change system state.

## Layout

- `home/` is the public chezmoi source state.
- `manifests/` defines common and profile-specific package groups.
- `scripts/` contains portable bootstrap and maintenance logic.
- `docs/private-overlay.md` describes the private chezmoi source and recovery
  process.

See [docs/operations.md](docs/operations.md) for updates, recovery, and
machine retirement.

## Test the Ubuntu bootstrap in a container

Docker or Podman can exercise the full Ubuntu `devbox` bootstrap without
changing the host. The test provisions packages, installs the pinned mise
tools, applies both chezmoi sources, and checks the resulting configuration.

With Docker installed and its daemon running:

```sh
mise run test-container
```

Use Podman instead by selecting the container engine:

```sh
CONTAINER_ENGINE=podman mise run test-container
```

On success the image is tagged `dotfiles-bootstrap-test:devbox`. Explore the
completed test machine with:

```sh
docker run --rm -it dotfiles-bootstrap-test:devbox
```

Remove it when finished:

```sh
docker image rm dotfiles-bootstrap-test:devbox
```

The test uses an empty local private-overlay fixture and a dummy age identity,
so it never accesses a private repository, Bitwarden, or personal secrets. It
does require network access for the packages, pinned tools, and vendor
downloads that normal bootstrap performs. It covers the headless Ubuntu
profile; test macOS and desktop-only configuration separately on a disposable
VM or machine.
