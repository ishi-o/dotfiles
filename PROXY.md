# Proxy

Proxy configuration has one source of truth:

```text
~/.config/proxy/config
```

## Before the first apply

From the chezmoi source directory, use `set-proxy`:

```sh
./set-proxy http://127.0.0.1:10808 socks5://127.0.0.1:10808
```

On Windows, use `Set-Proxy.ps1`:

```powershell
.\Set-Proxy.ps1 http://127.0.0.1:10808 socks5://127.0.0.1:10808
```

Package installers read the resulting configuration directly.

## Entry-point commands

The proxy command remains available through `dots` and `Dots`:

```sh
dots proxy http://127.0.0.1:10808 socks5://127.0.0.1:10808
dots proxy --show
dots proxy --sync
dots proxy --clear
```

```powershell
Dots proxy http://127.0.0.1:10808 socks5://127.0.0.1:10808
Dots proxy -Show
Dots proxy -Sync
Dots proxy -Clear
```

Proxy options are also accepted after any non-proxy `dots` or `Dots` command
and are applied before that command runs:

```sh
dots init --proxy http://127.0.0.1:10808 --socks socks5://127.0.0.1:10808
dots apply --proxy http://127.0.0.1:10808 --socks socks5://127.0.0.1:10808
dots install all --proxy http://127.0.0.1:10808
dots update --clear-proxy
```

```powershell
Dots init --proxy http://127.0.0.1:10808 --socks socks5://127.0.0.1:10808
Dots apply --proxy http://127.0.0.1:10808 --socks socks5://127.0.0.1:10808
Dots install all --proxy http://127.0.0.1:10808
Dots update --clear-proxy
```

## Direct command

After the repository has been applied, use the installed command:

```sh
set-proxy http://127.0.0.1:10808 socks5://127.0.0.1:10808
set-proxy --no-proxy "localhost,127.0.0.1,::1,.internal" \
  --http http://127.0.0.1:10808 \
  --socks socks5://127.0.0.1:10808
set-proxy --show
set-proxy --sync
set-proxy --clear
```

On Windows, use `Set-Proxy.ps1` with the same positional URLs and `-NoProxy`,
`-Show`, `-Sync`, `-Clear`, and `-Help` options.

## Consumers

The command stores the URLs once and derives all consumer settings from them:

- Shell environment: `HTTP_PROXY`, `HTTPS_PROXY`, `ALL_PROXY`, and `NO_PROXY`
- SSH: the managed `proxy-ssh` helper used by `.ssh/config`
- Git: `~/.config/proxy/gitconfig`, included by `~/.gitconfig`
- npm: `~/.config/npm/npmrc`
- Scoop: its persisted `proxy` setting on Windows

Do not edit these derived files directly. If a derived file is lost, run:

```sh
set-proxy --sync
```
