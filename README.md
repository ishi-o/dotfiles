# Dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/) for macOS,
Linux/WSL, MSYS2, and Windows.

## Install

Install chezmoi and Git manually.

<details>
<summary>macOS Homebrew</summary>

```sh
brew install chezmoi git
```

</details>

<details>
<summary>Linux / macOS</summary>

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

Bootstrap:

```sh
chezmoi init ishi-o
```

## Commands

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
Dots apply --scoop-prefix D:/Scoop
```

## Features

- Managed packages and runtimes
- PowerShell, Zsh, Bash, MSYS2, and WSL configuration
- Neovim-managed editor configuration
- Automatic font installation
- Optional WSL input-method support
- Private machine-local environment files

See [`PACKAGES.md`](PACKAGES.md) for package groups and installer ordering.

## Notes

- Use `.\Dots.cmd` on the first Windows run.
- Configure a proxy with `set-proxy` before the first apply when needed.
- The Windows shell is Zsh inside MSYS2 when MSYS2 and Zsh are installed.
- WSL uses mirrored networking.
- Set `INSTALL_FONTS=false` to disable automatic font installation.
- Do not commit credentials in `~/.config/env` or `~/.config/env.local.ps1`.

## Managed runtimes

| Runtime | Manager                         | Version    |
| ------- | ------------------------------- | ---------- |
| Go      | mise                            | latest     |
| Java    | mise                            | OpenJDK 21 |
| Lua     | mise, except Windows            | 5.4        |
| Node.js | nvm                             | 22         |
| Python  | uv                              | 3.13, 3.14 |
| Rust    | rustup                          | stable     |
| LuaJIT  | package manager or source build | 2.1        |
