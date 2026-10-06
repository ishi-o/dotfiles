$ErrorActionPreference = "Stop"

$archive = Join-Path $env:TEMP "cc-switch-cli.zip"
$destination = Join-Path $env:TEMP "cc-switch-cli"

Invoke-WebRequest `
  -Uri "https://github.com/SaladDay/cc-switch-cli/releases/latest/download/cc-switch-cli-windows-x64.zip" `
  -OutFile $archive
New-Item -ItemType Directory -Path $destination -Force | Out-Null
Expand-Archive -LiteralPath $archive -DestinationPath $destination -Force

$executable = Get-ChildItem -LiteralPath $destination -Recurse -Filter "cc-switch.exe" |
  Select-Object -First 1
if (-not $executable) {
  throw "cc-switch.exe was not found in the release archive"
}

Copy-Item -LiteralPath $executable.FullName -Destination (Join-Path $HOME ".local\bin\cc-switch.exe") -Force
