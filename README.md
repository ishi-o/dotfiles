# Dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/) for macOS
and Linux. Windows is also supported: packages are installed with Scoop, the
environment uses XDG-style directories, and the default shell is Zsh inside
MSYS2. The repository also manages shell and Kitty configuration, packages,
fonts, and an external Neovim configuration.

## Installation

```sh
sh -c "$(curl -fsLS https://get.chezmoi.io)" -- -b "$HOME/.local/bin"
export PATH="$HOME/.local/bin:$PATH"

chezmoi init https://github.com/ishi-o/dotfiles.git
chezmoi apply
```

Use `git@github.com:ishi-o/dotfiles.git` instead if GitHub SSH is configured.

`chezmoi apply` installs packages, downloads external files, and applies the
configuration. Start a new shell afterwards.

The installers ask before installing missing optional components. Pressing
Enter accepts the default answer.

## Repository command

`dots` is a task-oriented shortcut for this repository:

```sh
./dots init
./dots apply
./dots status
./dots diff
./dots install zsh
./dots install fonts
./dots install dev
```

Available install groups are `shell`, `build`, `runtimes`, `editor`,
`tools`/`dev`, `fonts`, `ai`, `terminal`, and `all`. Package names such as
`zsh`, `uv`, `mise`, `gh`, and `codegraph` can also be installed directly.

The repository-root `dots` file is a symlink to
`private_dot_local/bin/executable_dots` and is ignored by chezmoi.

## Proxy

Configure the proxies in `~/.zshenv` or `~/.bashrc`:

```sh
PROXY_URL_HTTP="http://127.0.0.1:10808"
PROXY_URL="socks5://127.0.0.1:10808"
```

`PROXY_URL_HTTP` is used for HTTP traffic; `PROXY_URL` is used as `ALL_PROXY`.
Before running `chezmoi init` or `chezmoi apply`, declare the variables once
in the current shell if they are not already active:

```sh
export PROXY_URL_HTTP="http://127.0.0.1:10808"
export PROXY_URL="socks5://127.0.0.1:10808"
export HTTP_PROXY="$PROXY_URL_HTTP"
export ALL_PROXY="$PROXY_URL"
export http_proxy="$PROXY_URL_HTTP"
export all_proxy="$PROXY_URL"
```

## Managed runtimes

[`private_dot_config/mise/config.toml`](private_dot_config/mise/config.toml)
defines the mise-managed runtimes:

| Runtime | Manager                         | Version    |
| ------- | ------------------------------- | ---------- |
| Go      | mise                            | latest     |
| Java    | mise                            | OpenJDK 21 |
| Lua     | mise                            | 5.4        |
| Node.js | nvm                             | 22         |
| Python  | uv                              | 3.13, 3.14 |
| Rust    | rustup                          | stable     |
| LuaJIT  | package manager or source build | 2.1        |

After the config is applied, a post-apply script runs `mise install`; it does
not modify the config with `mise use`. Bash and Zsh activate mise at startup.

## Fonts and Kitty

The default font is [Consolas ligaturized v3](https://github.com/somq/consolas-ligaturized).
Its fixed-pitch metadata is repaired automatically so Kitty can discover it on
macOS.

Maple Mono is optional:

```sh
KITTY_FONT=maple INSTALL_MAPLE_MONO=1 chezmoi apply
```

If it is already installed, omit `INSTALL_MAPLE_MONO=1`.

## Reapplying and rerunning installers

```sh
chezmoi diff
chezmoi apply
```

The main package installer is `run_once_before_` and is skipped after a
successful run. To rerun all `run_once_` scripts:

```sh
chezmoi state delete-bucket --bucket=scriptState
chezmoi apply
```

The font repair and mise installation scripts are `run_after_` scripts; they
run on every apply and are safe to repeat.

## Optional graphical input method

On WSL, the installer attempts to install `fcitx5` and its Chinese addons. It
starts only in a graphical session. WSLg uses the X11-compatible path and
Kitty uses XWayland; other Wayland environments keep their native path.

## Private environment variables

`~/.config/env` is a tracked private-permission file with placeholders for
machine-specific variables. Add local secrets there, but do not commit real
credentials to the source repository.
