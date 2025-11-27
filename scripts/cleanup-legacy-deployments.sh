#!/bin/bash
# =============================================================================
# Legacy Deployment Config Cleanup Script
# =============================================================================
#
# This script removes Railway and Vercel configuration files from all MADFAM
# repositories after migration to Enclii is complete.
#
# IMPORTANT: Only run this AFTER Enclii is deployed and all services are migrated!
#
# Usage: ./scripts/cleanup-legacy-deployments.sh [--dry-run]
# =============================================================================

set -euo pipefail

LABSPACE="/Users/aldoruizluna/labspace"
DRY_RUN=false

if [[ "${1:-}" == "--dry-run" ]]; then
    DRY_RUN=true
    echo "🔍 DRY RUN MODE - No files will be deleted"
    echo ""
fi

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║     MADFAM Legacy Deployment Config Cleanup                   ║"
echo "║     Removing Vercel/Railway configs after Enclii migration    ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""

# Files to remove
LEGACY_FILES=(
    # Forj
    "$LABSPACE/forj/vercel.json"
    "$LABSPACE/forj/railway.toml"
    "$LABSPACE/forj/.env.railway"

    # Digifab Quoting / Forgesight
    "$LABSPACE/digifab-quoting/vercel.json"
    "$LABSPACE/digifab-quoting/apps/web/vercel.json"
    "$LABSPACE/digifab-quoting/apps/web/apps/web/vercel.json"

    # Fortuna
    "$LABSPACE/fortuna/web/app/vercel.json"
    "$LABSPACE/fortuna/web/marketing/vercel.json"
    "$LABSPACE/fortuna/railway.toml"

    # Forgesight
    "$LABSPACE/forgesight/apps/app/vercel.json"
    "$LABSPACE/forgesight/apps/admin/vercel.json"
    "$LABSPACE/forgesight/apps/www/vercel.json"
    "$LABSPACE/forgesight/.env.railway"
    "$LABSPACE/forgesight/services/api/railway.toml"
    "$LABSPACE/forgesight/railway.json"

    # Janua
    "$LABSPACE/janua/config/vercel.json"
    "$LABSPACE/janua/config/railway.json"
    "$LABSPACE/janua/apps/api/railway.json"
    "$LABSPACE/janua/apps/marketing/vercel.json"

    # Simple sites
    "$LABSPACE/aureo-labs/vercel.json"
    "$LABSPACE/madfam-site/vercel.json"
    "$LABSPACE/primavera3d/vercel.json"

    # Sim4D
    "$LABSPACE/sim4d/apps/studio/vercel.json"
    "$LABSPACE/sim4d/apps/marketing/vercel.json"
)

# Count files
FOUND=0
REMOVED=0

echo "📋 Scanning for legacy deployment configs..."
echo ""

for file in "${LEGACY_FILES[@]}"; do
    if [[ -f "$file" ]]; then
        FOUND=$((FOUND + 1))
        if [[ "$DRY_RUN" == true ]]; then
            echo -e "${YELLOW}[WOULD DELETE]${NC} $file"
        else
            rm -f "$file"
            REMOVED=$((REMOVED + 1))
            echo -e "${GREEN}[DELETED]${NC} $file"
        fi
    fi
done

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [[ "$DRY_RUN" == true ]]; then
    echo -e "📊 Found ${YELLOW}$FOUND${NC} legacy config files"
    echo ""
    echo "Run without --dry-run to delete these files:"
    echo "  ./scripts/cleanup-legacy-deployments.sh"
else
    echo -e "✅ Removed ${GREEN}$REMOVED${NC} legacy config files"
    echo ""
    echo "Next steps:"
    echo "  1. Commit these changes: git add -A && git commit -m 'chore: remove legacy Vercel/Railway configs'"
    echo "  2. Push to all repositories"
    echo "  3. Delete Vercel/Railway projects from their dashboards"
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
