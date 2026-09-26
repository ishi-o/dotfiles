$ErrorActionPreference = "Stop"

scoop install ncat
if ($LASTEXITCODE -ne 0) {
    throw "scoop install ncat failed"
}
