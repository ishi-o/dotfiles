$ErrorActionPreference = "Stop"

. (Join-Path $PSScriptRoot "..\..\lib\win\helpers.ps1")

function Install-MsvcBuildTools {
    $vctoolsWorkload = "Microsoft.VisualStudio.Workload.VCTools"

    Write-Host "==> Checking for Visual Studio Build Tools..."
    $installed = winget list --id Microsoft.VisualStudio.2022.BuildTools --exact --accept-source-agreements 2>$null
    if ($LASTEXITCODE -eq 0 -and $installed -match "Microsoft.VisualStudio.2022.BuildTools") {
        Write-Host "Visual Studio Build Tools is already installed."
        return
    }

    Write-Host "==> Installing Visual Studio Build Tools with VCTools workload..."
    winget install Microsoft.VisualStudio.2022.BuildTools `
        --force `
        --silent `
        --wait `
        --accept-package-agreements `
        --accept-source-agreements `
        --override "--passive --add $vctoolsWorkload --includeRecommended"

    if ($LASTEXITCODE -ne 0) {
        throw "Visual Studio Build Tools installation failed with exit code $LASTEXITCODE"
    }

    Write-Host "==> Visual Studio Build Tools installed successfully."
    Write-Host "==> A system restart may be required before MSVC can be used."
}

Install-MsvcBuildTools
