# OpenClaw Docker Helper Script
# Quick commands to manage your OpenClaw Docker setup

param(
    [Parameter(Position=0)]
    [ValidateSet('start', 'stop', 'logs', 'status', 'onboard', 'health', 'cli', 'rebuild')]
    [string]$Command = 'status',
    
    [Parameter(Position=1, ValueFromRemainingArguments=$true)]
    [string[]]$Args
)

$RepoRoot = Split-Path -Parent $PSCommandPath
Set-Location $RepoRoot

$Token = "57a577be7c7115f87197232ee1a6edb1b216dba32443b20d9cdc7aeb6599f"

function Show-Help {
    Write-Host @"

OpenClaw Docker Helper

Usage: .\openclaw-docker.ps1 <command> [args]

Commands:
  start       Start the OpenClaw gateway
  stop        Stop the OpenClaw gateway
  logs        View gateway logs (follows by default)
  status      Check status of containers
  onboard     Run interactive onboarding wizard
  health      Check gateway health
  cli         Run a CLI command (e.g., cli config list)
  rebuild     Rebuild the Docker image

Examples:
  .\openclaw-docker.ps1 start
  .\openclaw-docker.ps1 logs
  .\openclaw-docker.ps1 cli config list
  .\openclaw-docker.ps1 cli providers login

"@ -ForegroundColor Cyan
}

switch ($Command) {
    'start' {
        Write-Host "Starting OpenClaw gateway..." -ForegroundColor Green
        docker compose up -d openclaw-gateway
        Start-Sleep -Seconds 2
        Write-Host "`nGateway started! Access it at: http://localhost:18789" -ForegroundColor Cyan
        Write-Host "Token: $Token" -ForegroundColor Yellow
    }
    
    'stop' {
        Write-Host "Stopping OpenClaw gateway..." -ForegroundColor Yellow
        docker compose down
    }
    
    'logs' {
        Write-Host "Viewing gateway logs (Ctrl+C to exit)..." -ForegroundColor Cyan
        docker compose logs -f openclaw-gateway
    }
    
    'status' {
        Write-Host "OpenClaw Container Status:" -ForegroundColor Cyan
        docker compose ps
        Write-Host "`nDocker Images:" -ForegroundColor Cyan
        docker images openclaw:local
    }
    
    'onboard' {
        Write-Host "Starting onboarding wizard..." -ForegroundColor Green
        Write-Host "Token (use when prompted): $Token" -ForegroundColor Yellow
        Write-Host ""
        docker compose run --rm openclaw-cli onboard --no-install-daemon
    }
    
    'health' {
        Write-Host "Checking gateway health..." -ForegroundColor Cyan
        docker compose exec openclaw-gateway node dist/index.js health --token "$Token"
    }
    
    'cli' {
        if ($Args.Count -eq 0) {
            Write-Host "Usage: .\openclaw-docker.ps1 cli <command>" -ForegroundColor Red
            Write-Host "Example: .\openclaw-docker.ps1 cli config list" -ForegroundColor Yellow
            exit 1
        }
        docker compose run --rm openclaw-cli @Args
    }
    
    'rebuild' {
        Write-Host "Rebuilding OpenClaw Docker image..." -ForegroundColor Yellow
        docker compose down
        docker build -t openclaw:local .
        Write-Host "`nRebuild complete! Use 'start' to launch the gateway." -ForegroundColor Green
    }
    
    default {
        Show-Help
    }
}
