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

If initialization or installation fails, check the configured mirror and network connection and then try again.
