# Quick Start - OpenClaw in Docker

## Status: Image Built Successfully ✅

Your OpenClaw Docker image has been built and is ready to run!

## Your Gateway Token

```
57a577be7c7115f87197232ee1a6edb1b216dba32443b20d9cdc7aeb6599f
```

**IMPORTANT:** Save this token securely - you'll need it to access the gateway UI.

## Next Steps

### Option 1: Complete Onboarding Interactively (Recommended)

Run the onboarding wizard to configure your bot:

```powershell
docker compose run --rm openclaw-cli onboard --no-install-daemon
```

During onboarding, you'll be prompted for:
1. **Security warning** - Accept to continue
2. **Model/Auth** - Choose your AI provider (Claude, OpenAI, etc.)
3. **Gateway bind** - Select `lan` (recommended for Docker)
4. **Gateway auth** - Select `token` 
5. **Gateway token** - Use the token above
6. **Tailscale** - Select `Off` (unless you're using Tailscale)
7. **Install daemon** - Already set to `No` via flag

### Option 2: Start Gateway with Minimal Config (Quick Test)

If you want to test the gateway first without full onboarding:

```powershell
# Start the gateway
docker compose up -d openclaw-gateway

# Check it's running
docker compose ps

# View logs
docker compose logs -f openclaw-gateway

# Access the control UI
# Open: http://localhost:18789
```

## Configuration

Your OpenClaw config is stored at:
- **Config**: `C:\Users\ian\.openclaw\`
- **Workspace**: `C:\Users\ian\.openclaw\workspace\`

These directories are mounted into the Docker container, so changes persist.

## Useful Commands

### Gateway Management
```powershell
# Start gateway
docker compose up -d openclaw-gateway

# Stop gateway
docker compose down

# View logs
docker compose logs -f openclaw-gateway

# Check health
docker compose exec openclaw-gateway node dist/index.js health --token "57a577be7c7115f87197232ee1a6edb1b216dba32443b20d9cdc7aeb6599f"
```

### CLI Commands
```powershell
# Run any CLI command
docker compose run --rm openclaw-cli <command>

# Examples:
docker compose run --rm openclaw-cli config list
docker compose run --rm openclaw-cli providers login
docker compose run --rm openclaw-cli providers add --provider telegram --token "<token>"
```

### Channel Setup

#### WhatsApp (QR Code)
```powershell
docker compose run --rm openclaw-cli providers login
```

#### Telegram Bot
```powershell
docker compose run --rm openclaw-cli providers add --provider telegram --token "<your-bot-token>"
```

#### Discord Bot
```powershell
docker compose run --rm openclaw-cli providers add --provider discord --token "<your-bot-token>"
```

## Access the Control UI

Once the gateway is running:
1. Open your browser to: http://localhost:18789
2. Go to Settings
3. Paste your token: `57a577be7c7115f87197232ee1a6edb1b216dba32443b20d9cdc7aeb6599f`
4. Configure your bot!

## Troubleshooting

### Gateway won't start
- Check logs: `docker compose logs openclaw-gateway`
- Verify ports are free: `netstat -ano | findstr "18789"`

### Can't access UI
- Ensure gateway is running: `docker compose ps`
- Check Windows Firewall settings
- Try: http://127.0.0.1:18789 instead of localhost

### Need to rebuild image
```powershell
docker compose down
docker build -t openclaw:local .
docker compose up -d openclaw-gateway
```

## Documentation

- Full docs: https://docs.openclaw.ai
- Gateway security: https://docs.openclaw.ai/gateway/security
- Providers: https://docs.openclaw.ai/providers

## Environment Variables

Your `.env` file has been created with these defaults:
- `OPENCLAW_GATEWAY_PORT=18789`
- `OPENCLAW_BRIDGE_PORT=18790`
- `OPENCLAW_GATEWAY_BIND=lan`
- `OPENCLAW_IMAGE=openclaw:local`

You can modify these in `.env` if needed.
