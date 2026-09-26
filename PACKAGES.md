# Package installers

This file is intentionally ignored by chezmoi. It documents the installer
inventory and the supported installation targets.

Installers are split by platform:

- POSIX: `.chezmoi-install/packages/posix/*.sh`
- Windows: `.chezmoi-install/packages/win/*.ps1`

Windows packages are installed with Scoop. Zsh is installed inside MSYS2.

## Install groups

| Group | Packages |
| ----- | -------- |
| `shell` | POSIX `zsh`; Windows `msys2` + `zsh` |
| `build` | `build-essential`, `unzip`, `m4`, `autoconf`, `automake`, `pkg-config`, `openssl`, `libevent`, `ncurses`, `utf8proc`, `gettext`, `libgpg-error`, `libgcrypt`, `libassuan`, `libksba`, `libnpth`, `texinfo`, `pinentry`, `gpg` |
| `runtimes` | `uv`, `mise`, `nvm`, `luajit`, `rust` |
| `editor` | `nvim` |
| `tools` / `dev` | `fzf`, `fd`, `tree`, `kubectl`, `ripgrep`, `xclip`, `tree-sitter`, `gh` |
| `fonts` | CJK fonts, `fcitx5` |
| `ai` | `codex`, `claude`, `mcp-hub`, `codegraph` |
| `terminal` | `tmux`, `kitty` |

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
