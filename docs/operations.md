# Operations

## Profiles

- `personal`: macOS or Ubuntu desktop, personal Git repositories under
  `~/repos/`.
- `work`: macOS or Ubuntu desktop. Public configuration remains generic; the
  private overlay owns MaxMind-specific configuration. Work repositories live
  under `~/mm-repos/`.
- `devbox`: Ubuntu-only, headless personal development. Ghostty is omitted.

The selected profile is stored in `~/.config/chezmoi/chezmoi.toml`. Change it
only deliberately, then inspect `mise run diff` before applying.

## Updates

Use `mise run update-config` to pull and apply both sources after confirmation.
Use `mise run update-packages` for package upgrades and `mise run
update-runtimes` to install the exact versions declared in `mise.toml`.

Neovim plugin and Mason changes are explicit: run `mise run nvim-sync`, review
the resulting `lazy-lock.json`, and commit it. Normal configuration checks do
not access the network.

## First Migration and Backups

The first bootstrap moves existing managed files into
`~/.local/state/dotfiles/backups/<timestamp>/` before applying chezmoi. These
backups are mode `0700`. Run `mise run backup-prune` to remove backups older
than 30 days.

This migration also retires the legacy symlink-managed `.vimrc`, `.vim/`,
`.wezterm.lua`, and `.z.sh` paths. Top-level symlinks are dereferenced while
backing up, so the backup retains their contents even after the old dotfiles
checkout is removed. The new public source does not manage those retired
paths; restore a file from the backup only deliberately.

## Machine Retirement

Remove the local `~/.config/chezmoi/key.txt`, revoke the machine's Bitwarden
SSH access, remove the private repository checkout, and rotate the shared age
identity when the machine cannot be securely wiped.
