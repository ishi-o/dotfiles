$ErrorActionPreference = "Stop"

if (-not (scoop bucket list | Where-Object { $_.Name -eq "dorado" })) {
    scoop bucket add dorado https://github.com/chawyehsu/dorado
    if ($LASTEXITCODE -ne 0) {
        throw "scoop bucket add dorado failed"
    }
}

scoop install dorado/fcitx5
if ($LASTEXITCODE -ne 0) {
    throw "scoop install dorado/fcitx5 failed"
}
