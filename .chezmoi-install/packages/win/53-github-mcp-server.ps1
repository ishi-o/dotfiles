$ErrorActionPreference = "Stop"

if (Get-Command github-mcp-server -ErrorAction SilentlyContinue) {
    return
}

$architecture = if ($env:PROCESSOR_ARCHITECTURE -eq "ARM64") {
    "arm64"
} else {
    "x86_64"
}

$archive = Join-Path $env:TEMP "github-mcp-server.zip"
$destination = Join-Path $env:TEMP "github-mcp-server"

Invoke-WebRequest `
  -Uri "https://github.com/github/github-mcp-server/releases/latest/download/github-mcp-server_Windows_${architecture}.zip" `
  -OutFile $archive
New-Item -ItemType Directory -Path $destination -Force | Out-Null
Expand-Archive -LiteralPath $archive -DestinationPath $destination -Force

$executable = Get-ChildItem -LiteralPath $destination -Recurse -Filter "github-mcp-server.exe" |
  Select-Object -First 1
if (-not $executable) {
    throw "github-mcp-server.exe was not found in the release archive"
}

Copy-Item -LiteralPath $executable.FullName -Destination (Join-Path $HOME ".local\bin\github-mcp-server.exe") -Force

Remove-Item -LiteralPath $archive -Force -ErrorAction SilentlyContinue
Remove-Item -LiteralPath $destination -Recurse -Force -ErrorAction SilentlyContinue
