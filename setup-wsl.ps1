# PowerShell script to set up WSL2 for OpenClaw Docker install

Write-Host "==> Setting up Node.js and systemd in WSL2..." -ForegroundColor Cyan

# Check if WSL is available
$wslAvailable = Get-Command wsl -ErrorAction SilentlyContinue
if (-not $wslAvailable) {
    Write-Host "ERROR: WSL is not available. Please install WSL2 first." -ForegroundColor Red
    exit 1
}

# Copy setup script to WSL
Write-Host "Copying setup script to WSL..." -ForegroundColor Yellow
$setupScript = Join-Path $PSScriptRoot "setup-wsl.sh"
$scriptContent = Get-Content $setupScript -Raw
$scriptContent | wsl bash -c "cat > /tmp/setup-wsl.sh"

# Make it executable and run it
Write-Host "Running setup script in WSL2..." -ForegroundColor Yellow
wsl bash /tmp/setup-wsl.sh

Write-Host ""
Write-Host "==> Setup script completed!" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "1. Shutdown WSL: wsl --shutdown" -ForegroundColor Yellow
Write-Host "2. Re-open WSL2 and verify: systemctl --user status" -ForegroundColor Yellow
Write-Host "3. Run Docker setup: ./docker-setup.sh" -ForegroundColor Yellow
