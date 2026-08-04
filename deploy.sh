#!/usr/bin/env bash
set -e

# ==============================================================================
# Automated Deployment Script for PDF Tools (Ubuntu + Docker)
# ==============================================================================

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}====================================================${NC}"
echo -e "${BLUE}        🚀 Deploying PDF Tools (Stirling-PDF)       ${NC}"
echo -e "${BLUE}====================================================${NC}"

# 1. Cek Docker & Docker Compose
if ! command -v docker &> /dev/null; then
    echo -e "${RED}[ERROR] Docker belum terinstall di server ini.${NC}"
    echo "Silakan install Docker terlebih dahulu: sudo apt update && sudo apt install -y docker.io docker-compose-v2"
    exit 1
fi

# 2. Siapkan file .env jika belum ada
if [ ! -f .env ]; then
    if [ -f .env.example ]; then
        echo -e "${YELLOW}[INFO] Creating .env from .env.example...${NC}"
        cp .env.example .env
    else
        echo -e "${YELLOW}[INFO] Creating default .env file...${NC}"
        cat <<EOT > .env
PORT=8880
SECURITY_ENABLELOGIN=true
SECURITY_LOGINMETHOD=all
ADMIN_USERNAME=admin
ADMIN_PASSWORD=StirlingPassword123!
SECURITY_OAUTH2_ENABLED=true
SECURITY_OAUTH2_PROVIDER=sipetra
SECURITY_OAUTH2_CLIENTID=019fca70-defd-73c4-b5d5-f2ac581a0792
SECURITY_OAUTH2_CLIENTSECRET=Efg9peKx0CFqxC9SgvZI5hqNMdyOgV8MktRo9bSw
SECURITY_OAUTH2_AUTHORIZATIONURI=https://bpsdemak.com/oauth/authorize
SECURITY_OAUTH2_TOKENURI=https://bpsdemak.com/oauth/token
SECURITY_OAUTH2_USERINFOURI=https://bpsdemak.com/api/user
SECURITY_OAUTH2_SCOPES=identity_pegawai:read, employee:read, contact:read, roles:read
SECURITY_OAUTH2_USEASUSERNAME=email
SECURITY_OAUTH2_AUTOCREATEUSER=true
SECURITY_OAUTH2_BLOCKREGISTRATION=false
APP_NAME=PDF Tools
LOCALE=id_ID
SYSTEM_DEFAULTTHEME=light
EOT
    fi
fi

# 3. Pastikan direktori persistent volume tersedia
mkdir -p customFiles/static extraConfigs trainingData pipeline

# 4. Mode penanganan argumen CLI
ACTION="${1:-deploy}"

case "$ACTION" in
    --logs|-l)
        echo -e "${BLUE}[INFO] Showing live container logs...${NC}"
        docker compose logs -f
        exit 0
        ;;
    --stop|-s)
        echo -e "${YELLOW}[INFO] Stopping PDF Tools container...${NC}"
        docker compose down
        echo -e "${GREEN}[SUCCESS] PDF Tools stopped.${NC}"
        exit 0
        ;;
    --build|-b)
        echo -e "${BLUE}[INFO] Fetching latest updates from Git...${NC}"
        git fetch --all 2>/dev/null || true
        git reset --hard origin/main 2>/dev/null || true
        docker compose build
        docker compose up -d --force-recreate
        ;;
    deploy|*)
        echo -e "${BLUE}[INFO] Fetching latest updates from Git...${NC}"
        git fetch --all 2>/dev/null || true
        git reset --hard origin/main 2>/dev/null || true
        docker compose pull
        docker compose up -d --remove-orphans
        ;;
esac

echo -e "${BLUE}----------------------------------------------------${NC}"
echo -e "${GREEN}✅ Deployment Selesai!${NC}"
echo -e "${BLUE}----------------------------------------------------${NC}"

# Ambil IP publik / lokal server
SERVER_IP=$(hostname -I 2>/dev/null | awk '{print $1}' || echo "IP_SERVER")
PORT=$(grep -E '^PORT=' .env | cut -d '=' -f 2 || echo "8880")

echo -e "${GREEN}Aplikasi dapat diakses melalui:${NC}"
echo -e "${BLUE}👉 http://${SERVER_IP}:${PORT}${NC}"
echo ""
echo -e "Gunakan perintah berikut untuk melihat log:"
echo -e "${YELLOW}./deploy.sh --logs${NC}"
echo -e "${BLUE}====================================================${NC}"
