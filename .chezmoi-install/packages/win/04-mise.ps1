$ErrorActionPreference = "Stop"

scoop install mise
if ($LASTEXITCODE -ne 0) {
    throw "scoop install mise failed"
}
