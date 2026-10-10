$ErrorActionPreference = "Stop"

. (Join-Path $PSScriptRoot "..\..\lib\win\helpers.ps1")

function Install-MsvcBuildTools {
    $vctoolsWorkload = "Microsoft.VisualStudio.Workload.VCTools"

    if (Test-MSVCAvailable) {
        Write-Host "==> MSVC is already installed."
        return
    }

    Write-Host "==> Installing Visual Studio Build Tools with VCTools workload..."
    winget install Microsoft.VisualStudio.2022.BuildTools `
        --silent `
        --wait `
        --accept-package-agreements `
        --accept-source-agreements `
        --override "--quiet --add $vctoolsWorkload --includeRecommended --norestart"

    if ($LASTEXITCODE -ne 0) {
        throw "Visual Studio Build Tools installation failed with exit code $LASTEXITCODE"
    }

    Write-Host "==> Visual Studio Build Tools installed successfully."
    Write-Host "==> A system restart may be required before MSVC can be used."
}

Install-MsvcBuildTools
