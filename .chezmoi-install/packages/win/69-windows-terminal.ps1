$ErrorActionPreference = "Stop"

scoop install extras/windows-terminal
if ($LASTEXITCODE -ne 0) {
    throw "scoop install extras/windows-terminal failed"
}
