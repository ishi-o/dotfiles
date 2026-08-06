## Installation

```sh
sh -c "$(curl -fsLS https://get.chezmoi.io)" # install chezmoi
chezmoi init https://github.com/ishi-o/dotfiles.git
chezmoi apply
```

Or initialize with an SSH key:

```sh
chezmoi init git@github.com:ishi-o/dotfiles.git
chezmoi apply
```

## Optional proxy

Set `PROXY_URL` before initialization or applying the configuration. For example:

```sh
export PROXY_URL="http://127.0.0.1:7890"
# Or: export PROXY_URL="socks5h://127.0.0.1:10808"
chezmoi init https://github.com/ishi-o/dotfiles.git
chezmoi apply
```

After initialization and applying the configuration, you can open `~/.zshenv`,
uncomment the `PROXY_URL` line, and customize the proxy address for future zsh sessions.

If initialization or installation fails, check your network connection and then try again.
