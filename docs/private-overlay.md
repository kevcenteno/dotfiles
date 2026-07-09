# Private Overlay

Create a private repository named `dotfiles-private` with this layout:

```text
home/
  encrypted_dot_config/dotfiles/git-personal.conf.age
  encrypted_dot_config/dotfiles/git-work.conf.age
  encrypted_dot_config/dot_ssh/conf.d/hosts.age
  dot_config/dotfiles/zshrc.local
```

The overlay is a second chezmoi source. It must only add files consumed by the
public configuration; it must not replace public targets such as `~/.zshrc` or
`~/.gitconfig`.

## Bootstrap contract

The public bootstrap clones `git@github.com:kevcenteno/dotfiles-private.git`.
Override this only when necessary with `PRIVATE_DOTFILES_REPO`. The private
repository needs an SSH key available through the Bitwarden SSH agent before
bootstrap starts.

On first use, the bootstrap logs into Bitwarden, unlocks it, reads the note
named `dotfiles-age-identity`, and writes the shared age identity to
`~/.config/chezmoi/key.txt` with mode `0600`. Set `BW_AGE_ITEM` to use a
different item name.

The private chezmoi source is applied only after this key exists. Bitwarden
session tokens are kept only in the bootstrap process environment.

## Rotation and Recovery

The shared age identity is a deliberate convenience tradeoff. If any machine
is lost or compromised:

1. Generate a new age identity.
2. Replace the Bitwarden note.
3. Re-encrypt every private source file to the new recipient.
4. Remove the old local key on machines you still control.
5. Re-run `mise run apply` on each remaining machine.

The public repository must never contain the age identity, Bitwarden session
tokens, SSH private keys, MaxMind-specific configuration, or unencrypted
secrets.
