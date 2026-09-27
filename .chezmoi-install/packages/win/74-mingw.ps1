$ErrorActionPreference = "Stop"

scoop install mingw
if ($LASTEXITCODE -ne 0) {
    throw "scoop install mingw failed"
}
