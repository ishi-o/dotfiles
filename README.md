# Dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/) for macOS, Linux/WSL, MSYS2 and Windows.

## Installation

**chezmoi and Git are prerequisites and must be installed manually.**

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

If package downloads require a proxy, use `set-proxy` before the first apply and see [`PROXY.md`](PROXY.md).

After that, use the `dots` entrypoint for everything.

POSIX:

```sh
dots init
dots update
dots update --init
dots install <target>
```

Windows:

```powershell
.\Dots.cmd init
Dots update
Dots update --init
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
available. MSYS2 is configured so that its home directory resolves to the Windows user profile (`C:\Users\<username>`).
And its path also contains scoop shims/Program Files on Win.

## Managed runtimes

[`private_dot_config/mise/config.toml.tmpl`](private_dot_config/mise/config.toml.tmpl)
defines the mise-managed runtimes:

| Runtime | Manager                         | Version    |
| ------- | ------------------------------- | ---------- |
| Go      | mise                            | latest     |
| Java    | mise                            | OpenJDK 21 |
| Lua     | mise (not on Windows)           | 5.4        |
| Node.js | nvm                             | 22         |
| Python  | uv                              | 3.13, 3.14 |
| Rust    | rustup                          | stable     |
| LuaJIT  | package manager or source build | 2.1        |

After the config is applied, a post-apply script runs `mise install`; it does not modify the config with `mise use`.

## Fonts

The fonts are installed automatically from [Consolas+NF+LXGWWenKai Mono](https://github.com/ishi-o/assets/releases/tag/fonts-v1.0).
Set INSTALL_FONTS=false before apply and update fontconfig if you want to install fonts by yourself.

## Optional graphical input method

On WSL, the installer attempts to install `fcitx5` and its Chinese addons. It
starts only in a graphical session. WSLg uses the X11-compatible path and
Kitty uses XWayland; other Wayland environments keep their native path.

## Private environment variables

`~/.config/env` is a tracked private-permission file with placeholders for
machine-specific variables. Add local secrets there, but do not commit real
credentials to the source repository.
