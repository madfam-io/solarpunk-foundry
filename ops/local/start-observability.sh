#!/bin/bash
# ============================================
# MADFAM Observability Stack Startup
# ============================================
# Starts PostHog and dependencies for local dev
# Requires: docker-compose.shared.yml running first
# ============================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔭 MADFAM Observability Stack${NC}"
echo "=================================="

# Check if shared network exists
if ! docker network ls | grep -q "madfam-shared-network"; then
    echo -e "${YELLOW}⚠️  Shared network not found. Starting shared infrastructure first...${NC}"
    docker compose -f docker-compose.shared.yml up -d
    echo -e "${GREEN}✅ Shared infrastructure started${NC}"
    sleep 5
fi

# Start observability stack
echo -e "${BLUE}🚀 Starting PostHog stack...${NC}"
docker compose -f docker-compose.observability.yml up -d

# Wait for PostHog to be healthy
echo -e "${YELLOW}⏳ Waiting for PostHog to be ready (this may take 2-3 minutes on first run)...${NC}"

MAX_ATTEMPTS=60
ATTEMPT=0

while [ $ATTEMPT -lt $MAX_ATTEMPTS ]; do
    if curl -s -f http://localhost:8100/_health/ > /dev/null 2>&1; then
        echo -e "${GREEN}✅ PostHog is ready!${NC}"
        break
    fi
    ATTEMPT=$((ATTEMPT + 1))
    echo -ne "\r⏳ Waiting... ($ATTEMPT/$MAX_ATTEMPTS)"
    sleep 5
done

if [ $ATTEMPT -eq $MAX_ATTEMPTS ]; then
    echo -e "${RED}❌ PostHog failed to start. Check logs with: docker logs madfam-posthog${NC}"
    exit 1
fi

echo ""
echo -e "${GREEN}============================================${NC}"
echo -e "${GREEN}🎉 Observability Stack Ready!${NC}"
echo -e "${GREEN}============================================${NC}"
echo ""
echo -e "📊 PostHog:        ${BLUE}http://localhost:8100${NC}"
echo -e "📧 MailHog:        ${BLUE}http://localhost:8025${NC}"
echo ""
echo -e "${YELLOW}First time setup:${NC}"
echo "1. Open http://localhost:8100"
echo "2. Create your admin account"
echo "3. Copy your Project API Key"
echo "4. Add to your apps' .env files"
echo ""
echo -e "${YELLOW}For production, remember to:${NC}"
echo "- Set POSTHOG_SECRET_KEY to a secure random value"
echo "- Configure proper email settings"
echo "- Set up SSL/TLS"
echo ""
