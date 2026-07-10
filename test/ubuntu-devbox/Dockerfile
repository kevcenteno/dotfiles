FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive \
    HOME=/home/dotfiles \
    XDG_CONFIG_HOME=/home/dotfiles/.config \
    XDG_DATA_HOME=/home/dotfiles/.local/share \
    XDG_STATE_HOME=/home/dotfiles/.local/state

# bootstrap requires sudo even when it runs as root. These are the only
# prerequisites deliberately installed outside the repository's manifests.
RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates curl git sudo \
    && useradd --create-home --shell /bin/zsh dotfiles \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
COPY . /workspace

# The production bootstrap expects an encrypted private source. The test only
# needs its contract: a Git checkout with a home/ source plus an existing age
# identity, so it never contacts Bitwarden or a private repository.
RUN mkdir -p "$XDG_CONFIG_HOME/chezmoi" "$XDG_DATA_HOME/dotfiles-private/home" \
    && git -C "$XDG_DATA_HOME/dotfiles-private" init --quiet \
    && printf '%s\n' 'test-only-age-identity' > "$XDG_CONFIG_HOME/chezmoi/key.txt" \
    && chmod 600 "$XDG_CONFIG_HOME/chezmoi/key.txt"

# Reproduce a subset of the legacy symlink layout. The verifier removes this
# old checkout to prove the migration backup contains the actual contents.
RUN mkdir -p /legacy/prefs/vim \
    && printf '%s\n' '[legacy]' 'name = old-gitconfig' > /legacy/prefs/gitconfig \
    && printf '%s\n' 'legacy vimrc' > /legacy/prefs/vimrc \
    && printf '%s\n' 'legacy vim directory' > /legacy/prefs/vim/marker \
    && printf '%s\n' 'legacy wezterm' > /legacy/prefs/wezterm.lua \
    && printf '%s\n' 'legacy z.sh' > /legacy/prefs/z.sh \
    && ln -s /legacy/prefs/gitconfig "$HOME/.gitconfig" \
    && ln -s /legacy/prefs/vimrc "$HOME/.vimrc" \
    && ln -s /legacy/prefs/vim "$HOME/.vim" \
    && ln -s /legacy/prefs/wezterm.lua "$HOME/.wezterm.lua" \
    && ln -s /legacy/prefs/z.sh "$HOME/.z.sh"

ENV DOTFILES_PROFILE=devbox \
    PRIVATE_DOTFILES_DIR=/home/dotfiles/.local/share/dotfiles-private

RUN ./bootstrap
RUN sh test/ubuntu-devbox/verify.sh
RUN printf '%s\n' 'package main' 'func main() {}' > /tmp/sample.go \
    && mise exec -- nvim --headless /tmp/sample.go \
      "+lua assert(vim.wait(180000, function() return vim.uv.fs_stat(vim.fn.stdpath('data') .. '/site/parser/go.so') ~= nil end, 250), 'timed out waiting for the Go parser')" +qa
RUN chown -R dotfiles:dotfiles "$HOME"

USER dotfiles
RUN ! zsh -ic 'prompt_status' | grep -F '⚡'

CMD ["/bin/zsh", "-l"]
