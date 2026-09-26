# Package installers

This file is intentionally ignored by chezmoi. It documents the installer
inventory and the supported installation targets.

Installers are split by platform:

- POSIX: `.chezmoi-install/packages/posix/*.sh`
- Windows: `.chezmoi-install/packages/win/*.ps1`

## Windows

### Prerequisite: Git

chezmoi clones and updates the source repository through Git, so Git must be
available on `PATH` before `dots init` or `dots apply` is run. Install it
from the official Git for Windows installer or with `winget install Git.Git`.
The repository does not ship an installer for Git itself.

If a specific install location is required, choose it during the official
installer's setup.

### Packages

All other Windows packages are installed with Scoop. Scoop installs to
`%USERPROFILE%\scoop` by default. To install it somewhere else, pass
`--scoop-prefix` to any `dots` command:

```sh
./dots apply --scoop-prefix D:/Scoop
```

or set `SCOOP_DIR` when running the full installer directly:

```powershell
$env:SCOOP_DIR = "D:\Scoop"
./main.ps1
```

The installer assigns `SCOOP_DIR` to `SCOOP`, persists it to the user
environment, and then runs the official Scoop installer, which honors the
variable. All packages installed afterwards land under the chosen directory.

Zsh is installed inside MSYS2.

## Install groups

| Group           | Packages                                                                                                                                                                                                                      |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `shell`         | POSIX `zsh`; Windows `msys2` + `zsh`                                                                                                                                                                                          |
| `build`         | `build-essential`, `unzip`, `m4`, `autoconf`, `automake`, `pkg-config`, `openssl`, `libevent`, `ncurses`, `utf8proc`, `gettext`, `libgpg-error`, `libgcrypt`, `libassuan`, `libksba`, `libnpth`, `texinfo`, `pinentry`, `gpg` |
| `runtimes`      | `uv`, `mise`, `nvm`, `luajit`, `rust`                                                                                                                                                                                         |
| `editor`        | `nvim`                                                                                                                                                                                                                        |
| `tools` / `dev` | `fzf`, `fd`, `tree`, `kubectl`, `ripgrep`, `xclip`, `tree-sitter`, `gh`                                                                                                                                                       |
| `fonts`         | CJK fonts, `fcitx5`                                                                                                                                                                                                           |
| `ai`            | `codex`, `claude`, `mcp-hub`, `codegraph`                                                                                                                                                                                     |
| `terminal`      | `tmux`, `kitty`                                                                                                                                                                                                               |

## Targeted installation

Use `dots` to install a group or an individual package:

```sh
./dots install shell
./dots install build
./dots install ai
./dots install codegraph
```

During a full install, missing optional components are confirmed
interactively. Pressing Enter accepts the default answer.
