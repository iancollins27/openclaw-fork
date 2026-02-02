#!/usr/bin/env bash
set -euo pipefail

echo "==> Setting up Node.js 22 in WSL2..."

# Install Node.js 22
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo bash -
sudo apt-get install -y nodejs

echo ""
echo "==> Verifying Node.js installation..."
node --version
npm --version

echo ""
echo "==> Installing pnpm (recommended for OpenClaw)..."
npm install -g pnpm

echo ""
echo "==> Enabling systemd in WSL2..."
sudo tee /etc/wsl.conf >/dev/null <<'EOF'
[boot]
systemd=true
EOF

echo ""
echo "==> Setup complete!"
echo ""
echo "Next steps:"
echo "1. Close this WSL terminal"
echo "2. From PowerShell, run: wsl --shutdown"
echo "3. Re-open WSL2 and verify systemd: systemctl --user status"
echo "4. Then run the Docker setup from the repo root: ./docker-setup.sh"
