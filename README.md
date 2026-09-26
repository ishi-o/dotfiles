# Dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/) for macOS
and Linux. Windows is also supported: packages are installed with Scoop, the
environment uses XDG-style directories, and the default shell is Zsh inside
MSYS2. The repository also manages shell and Kitty configuration, packages,
fonts, and an external Neovim configuration.

## Installation

chezmoi and Git are prerequisites and must be installed manually.

<details>
<summary>MacOS Homebrew</summary>

```sh
brew install chezmoi git
```

</details>

<details>
<summary>Linux / MacOS</summary>

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin"
```

</details>

<details>
<summary>Windows</summary>

```powershell
winget install twpayne.chezmoi
winget install Git.Git
```

</details>

Bootstrap the source with chezmoi once:

```sh
chezmoi init ishi-o
```

After that, use the `dots` entry point for everything.

POSIX:

```sh
dots init
dots update
dots install <target>
```

Windows:

```powershell
.\Dots.cmd init
Dots update
Dots install <target>
# Or install scoop and its packages in custom path
Dots apply --scoop-prefix D:/Scoop
```

On the first run, `Dots` is not yet in `PATH`; use `.\Dots.cmd` from the
repository root.

## Packages

See [`PACKAGES.md`](PACKAGES.md) for the full installer inventory and deeper
customization. The repository-root entry point drives everything after
bootstrap: `dots apply` / `Dots apply` and `dots update` / `Dots update` sync
the source, and `dots install <target>` / `Dots install <target>` install a
curated group or an individual package.

## Shell on Windows

On Windows, the default shell is Zsh inside MSYS2 when both MSYS2 and Zsh are
available. MSYS2 is configured so that its home directory resolves to the
Windows user profile
(`C:\Users\<user>`), which means the shell reads the same `.bashrc`,
`.zshrc`, `.gitconfig`, and `.config` files that chezmoi manages. No separate
MSYS2-specific configuration is required.

## Proxy

Configure the proxies in `~/.zshenv` or `~/.bashrc`:

```sh
PROXY_URL_HTTP="http://127.0.0.1:10808"
PROXY_URL="socks5://127.0.0.1:10808"
```

`PROXY_URL_HTTP` is used for HTTP traffic; `PROXY_URL` is used as `ALL_PROXY`.
Before applying the repository, declare the variables once in the current
shell if they are not already active:

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

Set `KITTY_FONT=maple` and `INSTALL_MAPLE_MONO=1` when applying the
repository.

If it is already installed, omit `INSTALL_MAPLE_MONO=1`.

## Optional graphical input method

On WSL, the installer attempts to install `fcitx5` and its Chinese addons. It
starts only in a graphical session. WSLg uses the X11-compatible path and
Kitty uses XWayland; other Wayland environments keep their native path.

## Private environment variables

`~/.config/env` is a tracked private-permission file with placeholders for
machine-specific variables. Add local secrets there, but do not commit real
credentials to the source repository.
