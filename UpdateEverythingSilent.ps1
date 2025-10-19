# ============================================
# Script: UpdateEverythingSilent.ps1
# Purpose: Automatically updates Winget apps, Windows, and opens Store updates
# Compatible: Windows 10/11 (including 25H2)
# Note: Microsoft Store apps must be updated manually
# ============================================

# ================================
# 0 - Check for Administrator privileges
# ================================
$currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal($currentUser)

if (-not $principal.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)) {
    # Relaunch with elevation if not admin
    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.FileName = "powershell.exe"
    $psi.Arguments = "-ExecutionPolicy Bypass -File `"$PSCommandPath`""
    $psi.Verb = "runas"
    try {
        [System.Diagnostics.Process]::Start($psi) | Out-Null
    } catch {
        Write-Warning "Elevation cancelled. Exiting script."
    }
    exit
}

Write-Host "=== STARTING FULL AUTOMATED UPDATE AS ADMIN ==="

# ================================
# 1 - Ensure ExecutionPolicy is RemoteSigned
# ================================
$currentPolicy = Get-ExecutionPolicy -Scope CurrentUser
if ($currentPolicy -ne "RemoteSigned") {
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
}

# ================================
# 2 - Update Winget apps
# ================================
try {
    Write-Host "`n[Step 1] Updating Winget apps..."
    winget upgrade --all --accept-package-agreements --accept-source-agreements
    Write-Host "Winget apps updated successfully."
}
catch {
    Write-Warning "Failed to update Winget apps: $_"
}

# ================================
# 3 - Update Windows via Windows Update
# ================================
try {
    Write-Host "`n[Step 2] Updating Windows..."
    if (-not (Get-Module -ListAvailable -Name PSWindowsUpdate)) {
        Install-Module PSWindowsUpdate -Force -Confirm:$false
    }
    Import-Module PSWindowsUpdate
    Get-WindowsUpdate -AcceptAll -Install -AutoReboot:$false | Out-Null
    Write-Host "Windows updates installed."
}
catch {
    Write-Warning "Failed to update Windows: $_"
}

# ================================
# 4 - Check if reboot is required
# ================================
$needsReboot = Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired" -ErrorAction SilentlyContinue

if ($needsReboot) {
    Write-Host "`nA system reboot is required to complete the updates."
    $response = Read-Host "Do you want to restart now? (Y/N)"
    if ($response -match "^[Yy]$") {
        Restart-Computer
    } else {
        Write-Host "Reboot postponed. Please restart manually later."
    }
} else {
    Write-Host "`nNo reboot required."
}

# ================================
# 5 - Open Microsoft Store updates page
# ================================
try {
    Write-Host "`nOpening Microsoft Store updates page..."
    Start-Process "ms-windows-store://downloadsandupdates"
    Write-Host "Microsoft Store opened. Click 'Get updates' to update Store apps."
}
catch {
    Write-Warning "Failed to open Microsoft Store updates page: $_"
}

Write-Host "`n=== AUTOMATED UPDATE PROCESS COMPLETED ==="
