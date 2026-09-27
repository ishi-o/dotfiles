#!/usr/bin/env pwsh

$ErrorActionPreference = "Stop"

function Show-Usage {
    @'
Usage: Dots <command> [args]

Commands:
  init                Reinitialize chezmoi, reset script state, and apply
  apply               Apply the current chezmoi state
  diff                Show pending changes
  status              Show chezmoi status
  edit                Open the source in the configured editor
  update              Pull the source repository and apply
  doctor              Run chezmoi doctor
  install <target>    Install a package or a curated group
  proxy [args]        Run Set-Proxy.ps1

Options (accepted by non-proxy commands):
  --scoop-prefix <dir>   Install Scoop under <dir>
  --proxy <url>          Set the HTTP/HTTPS proxy before running the command
  --socks <url>          Set the SOCKS proxy before running the command
  --no-proxy <list>      Set hosts which bypass the proxy
  --clear-proxy          Clear the proxy before running the command

Install groups:
  shell, build, runtimes, editor, tools, fonts, ai, terminal, all

Examples:
  Dots init
  Dots init --proxy http://127.0.0.1:10808 --socks socks5://127.0.0.1:10808
  Dots apply --scoop-prefix D:/Scoop
  Dots install fonts
  Dots install dev
  Dots proxy http://127.0.0.1:10808 socks5://127.0.0.1:10808
'@ | Write-Host
}

function Invoke-Installer {
    param([string]$Path)
    & $Path
}

function Get-SourceDir {
    (chezmoi source-path).Trim()
}

function Reset-ScriptState {
    $previousErrorActionPreference = $ErrorActionPreference
    $ErrorActionPreference = "Continue"
    $output = chezmoi state delete-bucket --bucket=scriptState 2>&1
    $exitCode = $LASTEXITCODE
    $ErrorActionPreference = $previousErrorActionPreference

    if ($exitCode -ne 0 -and "$output" -notmatch "bucket not found") {
        throw "chezmoi state delete-bucket failed: $output"
    }
}

function Initialize-Dots {
    param([string[]]$Rest = @())

    chezmoi init @Rest
    Reset-ScriptState
    chezmoi apply
}

function Get-ProxyScript {
    $localScript = Join-Path $PSScriptRoot "Set-Proxy.ps1"
    if (Test-Path -LiteralPath $localScript -PathType Leaf) {
        return $localScript
    }

    $sourceScript = Join-Path $PSScriptRoot "executable_Set-Proxy.ps1"
    if (Test-Path -LiteralPath $sourceScript -PathType Leaf) {
        return $sourceScript
    }

    $rootScript = Join-Path $PSScriptRoot "..\..\Set-Proxy.cmd"
    if (Test-Path -LiteralPath $rootScript -PathType Leaf) {
        return (Resolve-Path -LiteralPath $rootScript).Path
    }

    Write-Error "Set-Proxy.ps1 was not found"
    exit 1
}

function Find-Installer {
    param([string]$Target)
    $dir = Join-Path (Get-SourceDir) ".chezmoi-install\packages\win"
    Get-ChildItem -LiteralPath $dir -Filter "*-${Target}.ps1" -File |
        Select-Object -First 1 -ExpandProperty FullName
}

function Install-Group {
    param([string]$Group)

    $dir = Join-Path (Get-SourceDir) ".chezmoi-install\packages\win"
    $packages = switch ($Group) {
        "shell"    { @("01-msys2") }
        "build"    { @("02-build-essential","05-unzip","10-m4","11-autoconf","12-automake","13-pkg-config","20-openssl","21-libevent","30-ncurses","31-utf8proc","40-gettext","41-libgpg-error","42-libgcrypt","43-libassuan","44-libksba","45-libnpth","46-texinfo","47-pinentry","48-gpg") }
        "runtimes" { @("03-uv","04-mise","56-nvm","62-luajit","70-rust","74-mingw") }
        "editor"   { @("50-nvim") }
        "tools"    { @("60-fzf","63-fd","64-tree","65-kubectl","66-ripgrep","67-xclip","68-netcat","72-tree-sitter","73-gh") }
        "dev"      { @("60-fzf","63-fd","64-tree","65-kubectl","66-ripgrep","67-xclip","68-netcat","72-tree-sitter","73-gh") }
        "fonts"    { @("06-cjk-fonts","07-fcitx5") }
        "ai"       { @("57-codex","58-claude","59-mcp-hub","59-codegraph") }
        "terminal" { @("32-tmux","69-windows-terminal") }
        "all"      { Invoke-Installer (Join-Path (Get-SourceDir) ".chezmoi-install\main.ps1"); return }
        default    { Write-Error "Unknown install group: $Group"; Show-Usage; exit 2 }
    }

    foreach ($pkg in $packages) {
        $installer = Get-ChildItem -LiteralPath $dir -Filter "${pkg}.ps1" -File |
            Select-Object -First 1 -ExpandProperty FullName
        if (-not $installer) {
            Write-Error "Installer not found for package: $pkg"
            exit 1
        }
        Write-Host "==> Installing $pkg"
        Invoke-Installer $installer
    }
}

if ($args.Count -gt 0 -and $args[0] -eq "proxy") {
    $proxyRest = if ($args.Count -gt 1) { $args[1..($args.Count - 1)] } else { @() }
    & (Get-ProxyScript) @proxyRest
    if (-not $?) {
        exit 1
    }
    exit 0
}

$scoopPrefix = ""
$proxyHttp = ""
$proxySocks = ""
$proxyNoProxy = ""
$proxyClear = $false
$argsList = @()

$i = 0
while ($i -lt $args.Count) {
    switch ($args[$i]) {
        "--scoop-prefix" {
            $i++
            if ($i -ge $args.Count) { Write-Error "--scoop-prefix requires a path"; exit 2 }
            $scoopPrefix = $args[$i]
            $i++
        }
        "--proxy" {
            $i++
            if ($i -ge $args.Count) { Write-Error "--proxy requires a URL"; exit 2 }
            $proxyHttp = $args[$i]
            $i++
        }
        "--socks" {
            $i++
            if ($i -ge $args.Count) { Write-Error "--socks requires a URL"; exit 2 }
            $proxySocks = $args[$i]
            $i++
        }
        "--no-proxy" {
            $i++
            if ($i -ge $args.Count) { Write-Error "--no-proxy requires a list"; exit 2 }
            $proxyNoProxy = $args[$i]
            $i++
        }
        "--clear-proxy" {
            $proxyClear = $true
            $i++
        }
        default {
            $argsList += $args[$i]
            $i++
        }
    }
}

if ($scoopPrefix) { $env:SCOOP_DIR = $scoopPrefix }

$proxyParameters = @{}
if ($proxyHttp) { $proxyParameters.Http = $proxyHttp }
if ($proxySocks) { $proxyParameters.Socks = $proxySocks }
if ($proxyNoProxy) { $proxyParameters.NoProxy = $proxyNoProxy }
if ($proxyClear) {
    if ($proxyParameters.Count -gt 0) {
        Write-Error "--clear-proxy cannot be combined with other proxy options"
        exit 2
    }
    $proxyParameters.Clear = $true
}
if ($proxyParameters.Count -gt 0) {
    & (Get-ProxyScript) @proxyParameters
    if (-not $?) {
        exit 1
    }
}

$command = if ($argsList.Count -gt 0) { $argsList[0] } else { "help" }
$rest = @()
if ($argsList.Count -gt 1) {
    $rest = @($argsList[1..($argsList.Count - 1)])
}

switch ($command) {
    "init" {
        Initialize-Dots @rest
    }
    "apply" {
        chezmoi apply @rest
    }
    "diff" {
        chezmoi diff @rest
    }
    "status" {
        chezmoi status @rest
    }
    "edit" {
        chezmoi edit @rest
    }
    "update" {
        git -C (Get-SourceDir) pull --ff-only
        Initialize-Dots @rest
    }
    "doctor" {
        chezmoi doctor @rest
    }
    "proxy" {
        & (Get-ProxyScript) @rest
        if (-not $?) {
            exit 1
        }
    }
    "install" {
        if ($rest.Count -eq 0) {
            Write-Error "Dots install requires a package or group name"
            exit 2
        }
        $target = $rest[0]
        switch ($target) {
            { $_ -in @("shell","build","runtimes","editor","tools","dev","fonts","ai","terminal","all") } {
                Install-Group $target
            }
            default {
                $installer = Find-Installer $target
                if (-not $installer) {
                    Write-Error "Installer not found for target: $target"
                    exit 1
                }
                Write-Host "==> Installing $target"
                Invoke-Installer $installer
            }
        }
    }
    { $_ -in @("help","-h","--help") } {
        Show-Usage
    }
    default {
        Write-Error "Unknown command: $command"
        Show-Usage
        exit 2
    }
}
