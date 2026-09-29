$PSStyle.FileInfo.Directory = $PSStyle.Foreground.FromRgb(141, 161, 1)
$PSStyle.FileInfo.Executable = $PSStyle.Foreground.FromRgb(248, 85, 82)
$PSStyle.FileInfo.SymbolicLink = $PSStyle.Foreground.FromRgb(53, 167, 124)
$PSStyle.Formatting.TableHeader = $PSStyle.Foreground.FromRgb(92, 106, 114)
$PSStyle.Formatting.Error = $PSStyle.Foreground.FromRgb(248, 85, 82)
$PSStyle.Formatting.Warning = $PSStyle.Foreground.FromRgb(223, 160, 0)
$PSStyle.Formatting.Verbose = $PSStyle.Foreground.FromRgb(58, 148, 197)
$PSStyle.Formatting.Debug = $PSStyle.Foreground.FromRgb(223, 105, 186)
Set-PSReadLineOption -Colors @{ Default = $PSStyle.Foreground.FromRgb(92, 106, 114) }
Set-PSReadLineOption -PredictionSource History

Add-Type -AssemblyName System.Windows.Forms

function Invoke-WtAction {
    param([Parameter(Mandatory = $true)][string[]]$WtArgs)
    & wt.exe -w 0 @WtArgs 2>$null
}

Set-PSReadLineOption -EditMode Vi
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

function OnViModeChange {
    if ($args[0] -eq 'Command') {
        Write-Host -NoNewline "`e[2 q"
    } else {
        Write-Host -NoNewline "`e[6 q"
    }
}
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $Function:OnViModeChange
Write-Host -NoNewline "`e[6 q"

function Save-PwshSession {
    $sessionDirectory = Join-Path $HOME ".config\powershell\sessions"
    $sessionFile = Join-Path $sessionDirectory "last.pwsh-session.json"
    $history = @(Get-History | ForEach-Object { $_.CommandLine })
    New-Item -ItemType Directory -Path $sessionDirectory -Force | Out-Null
    [pscustomobject]@{
        savedAt          = (Get-Date).ToString("o")
        workingDirectory = $PWD.Path
        history          = $history
    } | ConvertTo-Json | Set-Content -Path $sessionFile -Encoding UTF8
    Write-Host "Saved PowerShell session to $sessionFile"
}

function Get-PwshHistoryFilePaths {
    $historyPath = (Get-PSReadLineOption).HistorySavePath
    if (-not (Test-Path -LiteralPath $historyPath -PathType Leaf)) {
        return @()
    }

    $lines = @(Get-Content -LiteralPath $historyPath -Tail 1000)
    if ($lines.Count -eq 0) {
        return @()
    }
    [array]::Reverse($lines)

    $paths = foreach ($line in $lines) {
        $tokens = $null
        $errors = $null
        $ast = [System.Management.Automation.Language.Parser]::ParseInput(
            $line,
            [ref]$tokens,
            [ref]$errors
        )
        $ast.FindAll({
            param($node)
            $node -is [System.Management.Automation.Language.StringConstantExpressionAst]
        }, $true) | ForEach-Object { $_.Value }
    }

    @(
        $paths |
            Where-Object { $_ -and (Test-Path -LiteralPath $_ -PathType Leaf) } |
            Select-Object -Unique
    )
}

function Invoke-PwshHistoryFilePicker {
    if (-not (Get-Command fzf -ErrorAction SilentlyContinue)) {
        return
    }

    $paths = @(Get-PwshHistoryFilePaths)
    if ($paths.Count -eq 0) {
        return
    }

    $selected = $paths | & fzf `
        "--prompt=History files> " `
        "--height=40%" `
        "--layout=reverse" `
        "--info=inline"
    if ([string]::IsNullOrWhiteSpace($selected)) {
        return
    }

    $quoted = "'" + $selected.Replace("'", "''") + "'"
    $line = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

    if ($line.Length -gt 0 -and
        $cursor -gt 0 -and
        -not [char]::IsWhiteSpace($line[$cursor - 1])) {
        [Microsoft.PowerShell.PSConsoleReadLine]::Insert(" $quoted")
    } else {
        [Microsoft.PowerShell.PSConsoleReadLine]::Insert($quoted)
    }
}

$wtPaneKeys = @{
    "Ctrl+h"       = @("move-focus", "-d", "left")
    "Ctrl+j"       = @("move-focus", "-d", "down")
    "Ctrl+k"       = @("move-focus", "-d", "up")
    "Ctrl+l"       = @("move-focus", "-d", "right")
    "Ctrl+Shift+h" = @("swap-pane", "-d", "left")
    "Ctrl+Shift+j" = @("swap-pane", "-d", "down")
    "Ctrl+Shift+k" = @("swap-pane", "-d", "up")
    "Ctrl+Shift+l" = @("swap-pane", "-d", "right")
}
foreach ($chord in $wtPaneKeys.Keys) {
    $wtArgs = $wtPaneKeys[$chord]
    Set-PSReadLineKeyHandler -Chord $chord -ScriptBlock {
        Invoke-WtAction -WtArgs $wtArgs
    }.GetNewClosure() -BriefDescription "Windows Terminal pane action"
}

$wtResizeKeys = @{
    "Alt+h" = "%+{LEFT}"
    "Alt+j" = "%+{DOWN}"
    "Alt+k" = "%+{UP}"
    "Alt+l" = "%+{RIGHT}"
}
foreach ($chord in $wtResizeKeys.Keys) {
    $relay = $wtResizeKeys[$chord]
    Set-PSReadLineKeyHandler -Chord $chord -ScriptBlock {
        [System.Windows.Forms.SendKeys]::SendWait($relay)
    }.GetNewClosure() -BriefDescription "Windows Terminal pane resize"
}

Set-PSReadLineKeyHandler -Chord Ctrl+o -Function ClearScreen
Set-PSReadLineKeyHandler -Chord Ctrl+y -Function AcceptSuggestion
Set-PSReadLineKeyHandler -Chord Ctrl+t -ScriptBlock {
    Invoke-PwshHistoryFilePicker
}
Set-PSReadLineKeyHandler -Chord @(
    "Ctrl+Shift+S"
    "Ctrl+b,Ctrl+s"
) -ScriptBlock {
    Save-PwshSession
    [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
} -BriefDescription "Save the current PowerShell session" `
    -Description "Saves the working directory and command history to last.pwsh-session.json."

Set-PSReadLineKeyHandler -ViMode Insert -Chord "j" -ScriptBlock {
    $key = [Console]::ReadKey($true)
    if ($key.KeyChar -eq 'j') {
        [Microsoft.PowerShell.PSConsoleReadLine]::ViCommandMode()
    } else {
        [Microsoft.PowerShell.PSConsoleReadLine]::Insert('j')
        [Microsoft.PowerShell.PSConsoleReadLine]::Insert($key.KeyChar)
    }
}

Set-PSReadLineKeyHandler -Chord Enter -ScriptBlock {
    param($key, $arg)

    $line = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

    $trimmed = $line.Trim()
    if ([string]::IsNullOrWhiteSpace($trimmed)) {
        [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
        return
    }

    if ($trimmed -eq '-') {
        [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
        [Microsoft.PowerShell.PSConsoleReadLine]::Insert('Set-Location -')
        [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
        return
    }

    if ($trimmed -match '\s') {
        [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
        return
    }

    if (Get-Command -Name $trimmed -ErrorAction SilentlyContinue) {
        [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
        return
    }

    $path = $trimmed.TrimEnd('\', '/')
    if ([string]::IsNullOrWhiteSpace($path)) {
        [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
        return
    }
    if ($path.Length -eq 2 -and $path[1] -eq ':') {
        $path += '\'
    }

    if (-not (Test-Path -LiteralPath $path -PathType Container)) {
        [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
        return
    }

    $resolvedPath = (Resolve-Path -LiteralPath $path).ProviderPath
    $literalPath = "'" + $resolvedPath.Replace("'", "''") + "'"
    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert("Set-Location -LiteralPath $literalPath")
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

Set-Alias -Name vi -Value nvim
Set-Alias -Name vim -Value nvim
Set-Alias -Name g -Value git

if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    Invoke-Expression (& { (zoxide init powershell | Out-String) })
}

function Expand-UniversalArchive {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$Path,

        [Parameter(Position = 1)]
        [string]$DestinationPath
    )

    $resolvedPath = (Resolve-Path -LiteralPath $Path -ErrorAction Stop).ProviderPath
    $item = Get-Item -LiteralPath $resolvedPath -ErrorAction Stop
    if (-not $item.PSIsContainer -and $item -isnot [System.IO.FileInfo]) {
        throw "Only files can be extracted: $resolvedPath"
    }
    if ($item.PSIsContainer) {
        throw "Archive path is a directory: $resolvedPath"
    }

    $archiveName = [System.IO.Path]::GetFileName($resolvedPath)
    $archiveStem = [System.IO.Path]::GetFileNameWithoutExtension($archiveName)
    $compoundExtensions = @(
        ".tar.bz2", ".tbz2", ".tar.gz", ".tgz", ".tar.lz", ".tar.lzma",
        ".tar.xz", ".txz", ".tar.zst", ".tzst"
    )
    foreach ($extension in $compoundExtensions) {
        if ($archiveName.EndsWith($extension, [System.StringComparison]::OrdinalIgnoreCase)) {
            $archiveStem = $archiveName.Substring(0, $archiveName.Length - $extension.Length)
            break
        }
    }

    if (-not $PSBoundParameters.ContainsKey("DestinationPath")) {
        $DestinationPath = Join-Path (Split-Path -Parent $resolvedPath) $archiveStem
    }
    $DestinationPath = [System.IO.Path]::GetFullPath($DestinationPath, $PWD.ProviderPath)
    if (Test-Path -LiteralPath $DestinationPath) {
        throw "Destination already exists: $DestinationPath"
    }
    New-Item -ItemType Directory -Path $DestinationPath -ErrorAction Stop | Out-Null

    if ($archiveName.EndsWith(".zip", [System.StringComparison]::OrdinalIgnoreCase)) {
        Expand-Archive -LiteralPath $resolvedPath -DestinationPath $DestinationPath -ErrorAction Stop
        return
    }

    $tarPattern = "\.(tar|tar\.bz2|tbz2|tar\.gz|tgz|tar\.lz|tar\.lzma|tar\.xz|txz|tar\.zst|tzst)$"
    if ($archiveName -match $tarPattern) {
        & tar.exe -xf $resolvedPath -C $DestinationPath
        if ($LASTEXITCODE -ne 0) {
            throw "tar failed with exit code $LASTEXITCODE"
        }
        return
    }

    $sevenZip = Get-Command 7z -ErrorAction SilentlyContinue
    if (-not $sevenZip) {
        throw "Install 7-Zip to extract this archive format: $archiveName"
    }

    & $sevenZip.Source x "-o$DestinationPath" -- $resolvedPath
    if ($LASTEXITCODE -ne 0) {
        throw "7-Zip failed with exit code $LASTEXITCODE"
    }
}
Set-Alias -Name x -Value Expand-UniversalArchive

if (Get-Module -ListAvailable PSFzf) {
    try {
        Import-Module PSFzf -ErrorAction Stop
        Set-PSReadLineKeyHandler -Key Tab -ScriptBlock {
            Invoke-FzfTabCompletion
        }
        Set-PsFzfOption -PSReadlineChordReverseHistory 'Ctrl+r'
    } catch {
        Write-Warning "Failed to initialize PSFzf: $($_.Exception.Message)"
    }
}
