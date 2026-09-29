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

$commandNotFoundPathHandler = {
    param([System.Management.Automation.Language.CommandAst]$CommandAst)

    if ($CommandAst.CommandElements.Count -ne 1) {
        return
    }

    $commandName = $CommandAst.GetCommandName()
    if ([string]::IsNullOrWhiteSpace($commandName) -or
        (Get-Command -Name $commandName -ErrorAction SilentlyContinue)) {
        return
    }

    $path = $commandName
    if (-not (Test-Path -LiteralPath $path -PathType Container)) {
        return
    }

    $resolvedPath = (Resolve-Path -LiteralPath $path).ProviderPath
    $literalPath = "'" + $resolvedPath.Replace("'", "''") + "'"
    $commandExtent = $CommandAst.CommandElements[0].Extent
    [Microsoft.PowerShell.PSConsoleReadLine]::Replace(
        $commandExtent.StartOffset,
        $commandExtent.EndOffset - $commandExtent.StartOffset,
        "Set-Location -LiteralPath $literalPath"
    )
}
Set-PSReadLineOption -CommandValidationHandler $commandNotFoundPathHandler
Set-PSReadLineKeyHandler -Chord Enter -Function ValidateAndAcceptLine

Add-Type -AssemblyName System.Windows.Forms

function Invoke-WtAction {
    param([Parameter(Mandatory = $true)][string[]]$WtArgs)
    & wt.exe -w 0 @WtArgs 2>$null
}

Set-PSReadLineOption -EditMode Vi

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
