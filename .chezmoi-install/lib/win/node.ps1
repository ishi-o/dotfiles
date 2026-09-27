function Initialize-Nvm {
    param([switch]$InstallNode)

    $nvmHome = (scoop prefix nvm).Trim()
    if (-not $nvmHome -or -not (Test-Path -LiteralPath $nvmHome -PathType Container)) {
        throw "NVM home not found"
    }

    $env:NVM_HOME = $nvmHome
    $env:NVM_SYMLINK = Join-Path $nvmHome "nodejs"
    [Environment]::SetEnvironmentVariable("NVM_HOME", $env:NVM_HOME, "User")
    [Environment]::SetEnvironmentVariable("NVM_SYMLINK", $env:NVM_SYMLINK, "User")
    $env:Path = "$env:NVM_HOME;$env:NVM_SYMLINK;$env:Path"

    $nvm = Join-Path $nvmHome "nvm.exe"

    $nvmSettings = Join-Path $nvmHome "settings.txt"
    if (Test-Path -LiteralPath $nvmSettings -PathType Leaf) {
        $settings = @(Get-Content -LiteralPath $nvmSettings)
        $officialSettings = @($settings | Where-Object {
            $_ -notmatch '^\s*(?:node_mirror|npm_mirror)\s*:'
        })
        if ($officialSettings.Count -ne $settings.Count) {
            Set-Content -LiteralPath $nvmSettings -Value $officialSettings
        }
    }

    if ($InstallNode) {
        & $nvm install 22
        if ($LASTEXITCODE -ne 0) {
            throw "nvm install 22 failed"
        }
    }

    & $nvm use 22
    if ($LASTEXITCODE -ne 0) {
        throw "nvm use 22 failed"
    }

    if (-not (Get-Command npm -ErrorAction SilentlyContinue)) {
        throw "npm was not found after enabling NVM"
    }

    npm config set registry https://registry.npmjs.org/
    if ($LASTEXITCODE -ne 0) {
        throw "npm official registry configuration failed"
    }
}
