#!/bin/bash
# Publish all MADFAM SDKs to npm.madfam.io
# Run from labspace directory

set -e

REGISTRY="https://npm.madfam.io"
LABSPACE="/Users/aldoruizluna/labspace"

echo "🚀 MADFAM SDK Publisher"
echo "========================"
echo "Registry: $REGISTRY"
echo ""

# Check if logged in
if ! npm whoami --registry $REGISTRY &>/dev/null; then
    echo "❌ Not logged in to $REGISTRY"
    echo "Run: npm login --registry $REGISTRY"
    exit 1
fi

echo "✅ Authenticated as: $(npm whoami --registry $REGISTRY)"
echo ""

# SDK locations
declare -A SDKS=(
    ["@madfam/ui"]="$LABSPACE/madfam-ui"
    ["@madfam/analytics"]="$LABSPACE/madfam-analytics"
    ["@madfam/geom-core"]="$LABSPACE/geom-core"
    ["@janua/react-sdk"]="$LABSPACE/janua/packages/react-sdk"
    ["@cotiza/client"]="$LABSPACE/digifab-quoting/packages/client"
    ["@fortuna/client"]="$LABSPACE/fortuna/packages/client"
    ["@avala/client"]="$LABSPACE/avala/packages/client"
    ["@forgesight/client"]="$LABSPACE/forgesight/packages/client"
    ["@coforma/client"]="$LABSPACE/coforma-studio/packages/client"
)

PUBLISHED=0
FAILED=0

for SDK in "${!SDKS[@]}"; do
    PKG_PATH="${SDKS[$SDK]}"

    if [ ! -d "$PKG_PATH" ]; then
        echo "⚠️  $SDK: Directory not found at $PKG_PATH"
        ((FAILED++))
        continue
    fi

    if [ ! -f "$PKG_PATH/package.json" ]; then
        echo "⚠️  $SDK: No package.json found"
        ((FAILED++))
        continue
    fi

    echo "📦 Publishing $SDK..."
    cd "$PKG_PATH"

    # Build if needed
    if [ -f "tsup.config.ts" ] || [ -f "tsup.config.js" ]; then
        if [ ! -d "dist" ]; then
            echo "   Building..."
            npm run build 2>/dev/null || pnpm build 2>/dev/null || true
        fi
    fi

    # Publish
    if npm publish --registry $REGISTRY 2>/dev/null; then
        echo "   ✅ Published successfully"
        ((PUBLISHED++))
    else
        # Check if already published (version exists)
        VERSION=$(node -p "require('./package.json').version")
        echo "   ⚠️  Failed or already published ($VERSION)"
        ((FAILED++))
    fi

    echo ""
done

echo "========================"
echo "📊 Summary"
echo "   Published: $PUBLISHED"
echo "   Failed/Skipped: $FAILED"
echo ""

if [ $PUBLISHED -gt 0 ]; then
    echo "✅ SDKs published to $REGISTRY"
fi
