$ErrorActionPreference = "Stop"

scoop install nmap
if ($LASTEXITCODE -ne 0) {
    throw "scoop install nmap failed"
}
