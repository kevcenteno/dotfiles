FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive \
    HOME=/root \
    XDG_CONFIG_HOME=/root/.config \
    XDG_DATA_HOME=/root/.local/share \
    XDG_STATE_HOME=/root/.local/state

# bootstrap requires sudo even when it runs as root. These are the only
# prerequisites deliberately installed outside the repository's manifests.
RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates curl git sudo \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
COPY . /workspace

# The production bootstrap expects an encrypted private source. The test only
# needs its contract: a Git checkout with a home/ source plus an existing age
# identity, so it never contacts Bitwarden or a private repository.
RUN mkdir -p /root/.config/chezmoi /root/.local/share/dotfiles-private/home \
    && git -C /root/.local/share/dotfiles-private init --quiet \
    && printf '%s\n' 'test-only-age-identity' > /root/.config/chezmoi/key.txt \
    && chmod 600 /root/.config/chezmoi/key.txt

# Reproduce a subset of the legacy symlink layout. The verifier removes this
# old checkout to prove the migration backup contains the actual contents.
RUN mkdir -p /legacy/prefs/vim \
    && printf '%s\n' '[legacy]' 'name = old-gitconfig' > /legacy/prefs/gitconfig \
    && printf '%s\n' 'legacy vimrc' > /legacy/prefs/vimrc \
    && printf '%s\n' 'legacy vim directory' > /legacy/prefs/vim/marker \
    && printf '%s\n' 'legacy wezterm' > /legacy/prefs/wezterm.lua \
    && printf '%s\n' 'legacy z.sh' > /legacy/prefs/z.sh \
    && ln -s /legacy/prefs/gitconfig /root/.gitconfig \
    && ln -s /legacy/prefs/vimrc /root/.vimrc \
    && ln -s /legacy/prefs/vim /root/.vim \
    && ln -s /legacy/prefs/wezterm.lua /root/.wezterm.lua \
    && ln -s /legacy/prefs/z.sh /root/.z.sh

ENV DOTFILES_PROFILE=devbox \
    PRIVATE_DOTFILES_DIR=/root/.local/share/dotfiles-private

RUN ./bootstrap
RUN sh test/ubuntu-devbox/verify.sh

CMD ["/bin/zsh", "-l"]
