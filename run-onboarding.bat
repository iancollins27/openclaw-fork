@echo off
echo Starting OpenClaw Onboarding...
echo.
echo Your gateway token (use when prompted):
echo 57a577be7c7115f87197232ee1a6edb1b216dba32443b20d9cdc7aeb6599f
echo.
echo During onboarding:
echo - Gateway bind: lan
echo - Gateway auth: token
echo - Gateway token: paste the token above
echo - Tailscale: Off
echo - Install daemon: No
echo.
pause
docker compose run --rm openclaw-cli onboard --no-install-daemon
