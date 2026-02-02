# Docker Setup Guide for OpenClaw

This guide will help you set up OpenClaw in Docker for secure, isolated operation.

## Prerequisites Check

You have:
- ✅ Docker Desktop installed
- ⚠️ Need: Ubuntu WSL2 distro (for running setup scripts)

## Step 1: Install Ubuntu in WSL2

Open PowerShell as Administrator and run:

```powershell
wsl --install -d Ubuntu-24.04
```

After installation, restart your computer if prompted, then open Ubuntu from the Start menu.

## Step 2: Set up Node.js and systemd in Ubuntu

Once Ubuntu is open, run these commands:

```bash
# Install Node.js 22
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo bash -
sudo apt-get install -y nodejs

# Verify installation
node --version  # Should show v22.x.x
npm --version

# Install pnpm (recommended)
npm install -g pnpm

# Enable systemd (required for some operations)
sudo tee /etc/wsl.conf >/dev/null <<'EOF'
[boot]
systemd=true
EOF
```

Then close Ubuntu and from PowerShell run:
```powershell
wsl --shutdown
```

Re-open Ubuntu and verify systemd:
```bash
systemctl --user status
```

## Step 3: Run Docker Setup

From your Windows machine, navigate to the OpenClaw repo in PowerShell:

```powershell
cd "c:\Users\ian\Code Projects\openclaw"
```

Then run the Docker setup script. You have two options:

### Option A: Run from Ubuntu WSL2 (Recommended)

Open Ubuntu WSL2 and navigate to the repo:

```bash
cd /mnt/c/Users/ian/Code\ Projects/openclaw
./docker-setup.sh
```

### Option B: Run from PowerShell with Git Bash

If you have Git Bash installed:

```powershell
bash docker-setup.sh
```

## What the Docker Setup Does

The `docker-setup.sh` script will:

1. **Build the Docker image** - Creates an isolated container with OpenClaw
2. **Run onboarding wizard** - Interactive setup for:
   - Model/auth configuration (API keys or OAuth)
   - Gateway settings
   - Channel setup (WhatsApp, Telegram, Discord, etc.)
3. **Generate secure token** - Creates a gateway authentication token
4. **Start the gateway** - Launches OpenClaw in Docker with proper isolation

## Security Features

- ✅ **Non-root user**: Container runs as `node` user (UID 1000), not root
- ✅ **Isolated volumes**: Config stored in `~/.openclaw/` on host, mounted into container
- ✅ **Network isolation**: Gateway runs in Docker network
- ✅ **Token authentication**: Gateway requires token for access
- ✅ **Controlled mounts**: Only specific directories are mounted

## After Setup

Once the gateway is running:

1. **Access Control UI**: Open `http://127.0.0.1:18789/` in your browser
2. **Paste token**: The setup script will show you the token - paste it into Settings → token
3. **Configure channels**: Use the CLI container to set up WhatsApp/Telegram/Discord:

```bash
# WhatsApp QR login
docker compose run --rm openclaw-cli channels login

# Telegram bot token
docker compose run --rm openclaw-cli channels add --channel telegram --token "<token>"

# Discord bot token  
docker compose run --rm openclaw-cli channels add --channel discord --token "<token>"
```

## Useful Commands

```bash
# View gateway logs
docker compose logs -f openclaw-gateway

# Check gateway health
docker compose exec openclaw-gateway node dist/index.js health --token "$OPENCLAW_GATEWAY_TOKEN"

# Stop gateway
docker compose down

# Start gateway
docker compose up -d openclaw-gateway
```

## Configuration Location

Your OpenClaw config is stored on the host at:
- `~/.openclaw/` - Main config directory
- `~/.openclaw/workspace/` - Agent workspace

These are mounted into the container, so you can edit them from Windows or WSL2.
