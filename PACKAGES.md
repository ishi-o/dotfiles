# Package installers

This file is intentionally ignored by chezmoi. It documents the installer
inventory and the supported installation targets.

Installers are split by platform:

- POSIX: `.chezmoi-install/packages/posix/*.sh`
- Windows: `.chezmoi-install/packages/win/*.ps1`

## Windows

Windows packages are installed with Scoop, which defaults to
`%USERPROFILE%\scoop`. AI tools (`codex`, `claude`, `mcp-hub`, and
`codegraph`) are installed globally with npm through nvm. To install Scoop
somewhere else, pass `--scoop-prefix` to any `Dots` command:

```powershell
Dots apply --scoop-prefix D:/Scoop
```

or set `SCOOP_DIR` when running the full installer directly:

```powershell
$env:SCOOP_DIR = "D:\Scoop"
.\main.ps1
```

The installer assigns `SCOOP_DIR` to `SCOOP`, persists it to the user
environment, and then runs the official Scoop installer, which honors the
variable. All packages installed afterwards land under the chosen directory.

Zsh is installed inside MSYS2. During MSYS2 installation, `nsswitch.conf` is
patched so that the MSYS2 home directory resolves to the Windows user
profile, allowing the shell to read the configuration files managed by
chezmoi directly.

## Install groups

| Group           | Packages                                                                                                                                                                                                                      |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `shell`         | POSIX `zsh`; Windows `msys2` + `zsh`                                                                                                                                                                                          |
| `build`         | `build-essential`, `unzip`, `m4`, `autoconf`, `automake`, `pkg-config`, `openssl`, `libevent`, `ncurses`, `utf8proc`, `gettext`, `libgpg-error`, `libgcrypt`, `libassuan`, `libksba`, `libnpth`, `texinfo`, `pinentry`, `gpg` |
| `runtimes`      | `uv`, `mise`, `nvm`, `luajit`, `rust`                                                                                                                                                                                         |
| `editor`        | `nvim`                                                                                                                                                                                                                        |
| `tools` / `dev` | `fzf`, `fd`, `tree`, `kubectl`, `ripgrep`, `xclip`, `netcat` (`nc`/`ncat`), `tree-sitter`, `gh`                                                                                                                                   |
| `fonts`         | CJK fonts, `fcitx5`                                                                                                                                                                                                           |
| `ai`            | `codex`, `claude`, `mcp-hub`, `codegraph` (npm)                                                                                                                                                                               |
| `terminal`      | POSIX `tmux`, `kitty`; Windows `tmux`, Windows Terminal                                                                                                                                                                         |

## Targeted installation

Use `dots` (POSIX) or `Dots` (Windows) to install a group or an individual
package:

```sh
./dots install shell
./dots install build
./dots install ai
./dots install codegraph
```

The same commands work as `Dots install <target>` on Windows.

During a full install, missing optional components are confirmed
interactively. Pressing Enter accepts the default answer.
