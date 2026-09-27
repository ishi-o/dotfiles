# Dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/) for macOS
and Linux. Windows is also supported: packages are installed with Scoop, AI
tools are installed with npm, the environment uses XDG-style directories, and
the default shell is Zsh inside MSYS2. The repository also manages shell and
Kitty configuration, packages, fonts, and an external Neovim configuration.

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

If package downloads require a proxy, use `set-proxy` before the first apply
and see [`PROXY.md`](PROXY.md).

After that, use the `dots` entry point for everything.

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
available. MSYS2 is configured so that its home directory resolves to the
Windows user profile
(`C:\Users\<user>`), which means the shell reads the same `.bashrc`,
`.zshrc`, `.gitconfig`, and `.config` files that chezmoi manages. No separate
MSYS2-specific configuration is required.

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

After the config is applied, a post-apply script runs `mise install`; it does
not modify the config with `mise use`. Bash and Zsh activate mise at startup.
On MSYS2, activation uses a POSIX path for the mise executable.

## Fonts and Kitty

The default font is [YaHei Consolas Hybrid for Powerline](https://github.com/Magnetic2014/YaHei-Consolas-Hybrid-For-Powerline).
It is installed automatically and used by Kitty, Windows Terminal, Zed, and
Fcitx5.

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
