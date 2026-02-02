# OpenClaw Docker Setup - Complete! 🎉

## ✅ Status: Running Successfully

Your OpenClaw gateway is now running in Docker on WSL!

## 🔗 Access Information

- **Web UI**: http://localhost:18789
- **Gateway Token**: `57a577be7c7115f87197232ee1a6edb1b216dba32443b20d9cdc7aeb6599f`

### How to Access the Control UI

1. Open your browser to: **http://localhost:18789**
2. Click on **Settings** (gear icon)
3. Paste your token: `57a577be7c7115f87197232ee1a6edb1b216dba32443b20d9cdc7aeb6599f`
4. Start configuring your bot!

## 📊 Container Status

```
NAME: openclaw-openclaw-gateway-1
STATUS: Up and running
PORTS: 0.0.0.0:18789->18789, 0.0.0.0:18790->18790
IMAGE: openclaw:local
```

## 🛠 Quick Management Commands

I've created a helper script for you: `openclaw-docker.ps1`

### Start/Stop Gateway
```powershell
.\openclaw-docker.ps1 start    # Start the gateway
.\openclaw-docker.ps1 stop     # Stop the gateway
.\openclaw-docker.ps1 logs     # View live logs
.\openclaw-docker.ps1 status   # Check container status
```

### Configuration
```powershell
.\openclaw-docker.ps1 onboard  # Run full onboarding wizard
.\openclaw-docker.ps1 cli config list  # View current config
```

### Add Messaging Channels
```powershell
# WhatsApp (QR code login)
.\openclaw-docker.ps1 cli providers login

# Telegram Bot
.\openclaw-docker.ps1 cli providers add --provider telegram --token "YOUR_BOT_TOKEN"

# Discord Bot
.\openclaw-docker.ps1 cli providers add --provider discord --token "YOUR_BOT_TOKEN"
```

## 📁 Configuration Location

Your OpenClaw configuration is stored on your Windows machine:
- **Config directory**: `C:\Users\ian\.openclaw\`
- **Workspace**: `C:\Users\ian\.openclaw\workspace\`
- **Config file**: `C:\Users\ian\.openclaw\config.yaml`

These are automatically mounted into the Docker container, so any changes you make persist across container restarts.

## 🔧 What's Configured

The gateway is currently running with minimal configuration:
- **Mode**: local
- **Bind**: lan (accessible from your network)
- **Port**: 18789
- **Auth**: Token-based authentication
- **Model**: anthropic/claude-opus-4-5 (default)

## 📝 Next Steps

### 1. Configure Your AI Provider

The gateway needs API credentials to function. You can configure:
- **Anthropic Claude** (recommended)
- **OpenAI GPT**
- **Google Gemini**
- **Local models** (Ollama, etc.)

To configure, either:
- Use the web UI at http://localhost:18789
- Run the onboarding: `.\openclaw-docker.ps1 onboard`
- Edit the config file directly: `C:\Users\ian\.openclaw\config.yaml`

### 2. Add Messaging Channels

Connect OpenClaw to your preferred messaging platforms:

#### WhatsApp
```powershell
docker compose run --rm openclaw-cli providers login
# Scan the QR code with your phone
```

#### Telegram
1. Create a bot with [@BotFather](https://t.me/botfather)
2. Get your bot token
3. Run: `docker compose run --rm openclaw-cli providers add --provider telegram --token "YOUR_TOKEN"`

#### Discord
1. Create a bot in [Discord Developer Portal](https://discord.com/developers/applications)
2. Get your bot token
3. Run: `docker compose run --rm openclaw-cli providers add --provider discord --token "YOUR_TOKEN"`

### 3. Test Your Setup

Once configured:
1. Send a message to your bot on any connected channel
2. The bot should respond!
3. View logs: `.\openclaw-docker.ps1 logs`

## 🔍 Troubleshooting

### Gateway Not Accessible
```powershell
# Check if container is running
docker compose ps

# View logs for errors
docker compose logs openclaw-gateway

# Restart gateway
docker compose restart openclaw-gateway
```

### Port Already in Use
If port 18789 is taken, edit `.env` and change `OPENCLAW_GATEWAY_PORT`:
```
OPENCLAW_GATEWAY_PORT=18888
```
Then restart: `docker compose up -d openclaw-gateway`

### Configuration Issues
```powershell
# View current config
docker compose run --rm openclaw-cli config list

# Run onboarding again
docker compose run --rm openclaw-cli onboard --no-install-daemon

# Check config file
notepad C:\Users\ian\.openclaw\config.yaml
```

### Container Keeps Restarting
```powershell
# View full logs
docker logs openclaw-openclaw-gateway-1

# Check for permission issues
# Make sure C:\Users\ian\.openclaw\ is writable
```

## 📚 Documentation

- **Full Documentation**: https://docs.openclaw.ai
- **Security Guide**: https://docs.openclaw.ai/gateway/security
- **Provider Setup**: https://docs.openclaw.ai/providers
- **Docker Setup**: https://docs.openclaw.ai/platforms/docker

## 🐳 Docker Commands Reference

### Container Management
```powershell
# Start gateway
docker compose up -d openclaw-gateway

# Stop everything
docker compose down

# Restart gateway
docker compose restart openclaw-gateway

# View running containers
docker compose ps

# View logs (follow mode)
docker compose logs -f openclaw-gateway

# View last 50 log lines
docker compose logs --tail 50 openclaw-gateway
```

### CLI Commands
```powershell
# Run any CLI command
docker compose run --rm openclaw-cli <command>

# Examples:
docker compose run --rm openclaw-cli config list
docker compose run --rm openclaw-cli config get gateway.port
docker compose run --rm openclaw-cli config set gateway.port 18789
docker compose run --rm openclaw-cli providers status
docker compose run --rm openclaw-cli security audit
```

### Rebuild Image
```powershell
# If you update the code
docker compose down
docker build -t openclaw:local .
docker compose up -d openclaw-gateway
```

## 🔐 Security Notes

⚠️ **Important Security Reminders:**

1. **Keep your token secure** - Don't share it publicly
2. **Use allowlists** - Configure which users can interact with your bot
3. **Enable pairing** - Require users to pair before using the bot
4. **Limit tool access** - Only enable tools you actually need
5. **Regular audits** - Run: `docker compose run --rm openclaw-cli security audit`

Read the full security guide: https://docs.openclaw.ai/gateway/security

## 🎯 Quick Start Checklist

- [x] Docker image built
- [x] Container running
- [x] Web UI accessible
- [x] Token generated
- [ ] AI provider configured (do this next!)
- [ ] Messaging channel added
- [ ] First test message sent

## 💡 Tips

1. **Logs are your friend**: Use `.\openclaw-docker.ps1 logs` frequently
2. **Config changes**: Most config changes require a gateway restart
3. **Backup your config**: `C:\Users\ian\.openclaw\config.yaml` contains all settings
4. **Multiple environments**: You can create multiple `.env` files for different setups
5. **Development**: To work on the code, edit locally and rebuild the image

## 🆘 Need Help?

- Check the docs: https://docs.openclaw.ai
- View GitHub issues: https://github.com/openclaw/openclaw/issues
- Read the security guide before exposing to the internet!

---

**Your OpenClaw Gateway is Ready!** 🦞

Open http://localhost:18789 in your browser and start configuring your AI assistant!
