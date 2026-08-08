## Installation

```sh
# install chezmoi
# On a fresh machine the shell PATH does not yet include `~/.local/bin`, so
# prefix every chezmoi call with the full path until the new shell config takes
# effect.
sh -c "$(curl -fsLS https://get.chezmoi.io)" -- -b ~/.local/bin
export PATH="$HOME/.local/bin:$PATH"
```

```sh
chezmoi init https://github.com/ishi-o/dotfiles.git
chezmoi apply
```

Or initialize with an SSH key:

```sh
ssh-keygen
# generate the ssh keys and push the pub key into settings
chezmoi init git@github.com:ishi-o/dotfiles.git
chezmoi apply
```

## Optional proxy

Set `PROXY_URL` before initialization or applying the configuration. For example:

```sh
export PROXY_URL="http://127.0.0.1:7890"
# Or: export PROXY_URL="socks5h://127.0.0.1:10808"
export PATH="$HOME/.local/bin:$PATH"
chezmoi init https://github.com/ishi-o/dotfiles.git
chezmoi apply
```

After initialization and applying the configuration, you can open `~/.zshenv`,
uncomment the `PROXY_URL` line, and customize the proxy address for future zsh sessions.

If initialization or installation fails, check your network connection and then try again.

## Private environment variables

The shell configs source `~/.config/env` for secrets and machine-specific
variables (API keys, tokens, proxy settings, etc.). This file is managed by
chezmoi as a private file (restricted permissions) and starts empty. Add your
own variables there:

```sh
echo 'export OPENAI_API_KEY="sk-..."' >> ~/.config/env
echo 'export ANTHROPIC_API_KEY="sk-ant-..."' >> ~/.config/env
```

This file is not tracked in git -- it is local to each machine.

## Re-running installers

Package installers use `run_once_*` scripts tracked in chezmoi's state database.
Once a script has run, chezmoi skips it on future `apply` calls. To force all
installers to run again (e.g. after a failed run or a major version upgrade):

```sh
chezmoi state reset
chezmoi apply
```

Each installer has its own debounce guard (`check_installed`, file checks, etc.)
so re-running is safe -- already-installed packages are skipped automatically.

## Optional graphical input method

The fcitx5 integration is enabled only when `fcitx5` is installed and a graphical
session exposes `DISPLAY` or `WAYLAND_DISPLAY`. On WSL, this repository also checks
for `/mnt/wslg` as a conservative WSLg check; an external X11/Wayland server is
not auto-detected. The installer attempts to install `fcitx5` and
`fcitx5-chinese-addons` only in WSL.

WSLg is the Windows component that displays Linux GUI applications, such as a
Linux Kitty window, on the Windows desktop. It is not needed for a pure terminal
session or for native Windows Kitty. WSLg provides `DISPLAY`, `WAYLAND_DISPLAY`,
and `PULSE_SERVER`; these should normally not be declared manually. The shell
only reads `DISPLAY`/`WAYLAND_DISPLAY` to detect a graphical session, and starts
fcitx5 in the background. In WSLg, it starts `fcitx5 --disable=wayland -d`, sets
the `GTK_IM_MODULE`, `QT_IM_MODULE`, `SDL_IM_MODULE`, `XMODIFIERS`, and
`GLFW_IM_MODULE` compatibility variables, and makes Kitty use XWayland. Other
Wayland environments keep their native Fcitx5 path.

This WSLg choice follows the current [WSLg Weston configuration](https://github.com/microsoft/wslg/blob/main/config/weston.ini), whose input-method path is empty, and Fcitx's [Weston setup](https://fcitx-im.org/wiki/Setup_Fcitx_5), which requires an explicit input-method path for the native Weston frontend. It is a compatibility choice, not a claim that every WSLg version will crash in native Wayland mode.

## Fonts

The installer manages the [Consolas ligaturized v3](https://github.com/somq/consolas-ligaturized)
font and installs it into the current user's font directory on Linux and macOS.
