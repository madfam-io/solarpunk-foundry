# MADFAM Ecosystem - Production Readiness Roadmap

> **Last Updated:** 2025-11-26
> **Version:** 0.1.0

## Executive Summary

The MADFAM ecosystem is **pre-deployment** - all repositories exist and are structured, but no services are running in production yet. We are waiting for Hetzner server access to deploy Enclii (infrastructure), then Janua (auth), and cascade from there.

---

## Current State (As of 2025-11-26)

### ✅ Completed

| Item | Status | Notes |
|------|--------|-------|
| Repository structure | ✅ Done | 18 repos in labspace |
| GitHub governance | ✅ Done | CODEOWNERS, PR templates in all repos |
| Licenses per manifesto | ✅ Done | AGPL/MPL/Proprietary correctly assigned |
| CI/CD workflows | ✅ Done | All repos have GitHub Actions |
| Version standardization | ✅ Done | All packages at 0.1.0 |
| `@madfam/core` published | ✅ Done | v0.1.0 on npm |
| Cross-repo deps eliminated | ✅ Done | madfam-ui, madfam-configs, madfam-analytics dissolved |
| Shared infrastructure config | ✅ Done | PostgreSQL, Redis, MinIO in solarpunk-foundry |

### ⏳ Blocked on Infrastructure

| Item | Blocker | Next Step |
|------|---------|-----------|
| Enclii deployment | Hetzner server access | Deploy bare-metal PaaS |
| Janua deployment | Enclii | Deploy auth service |
| All other services | Janua | SSO integration |
| Domain DNS | Enclii | Point domains to server |

### 📋 Repositories

All 18 repositories are at version 0.1.0:

**Layer 1 - Soil (Infrastructure):**
- `enclii` - Sovereign PaaS (AGPL v3)
- `janua` - Auth & Revenue (AGPL v3)

**Layer 2 - Roots (Data/Intelligence):**
- `fortuna` - Problem Intelligence (Proprietary)
- `forgesight` - Manufacturing Costs (Proprietary)
- `blueprint-harvester` - 3D Model Index (Proprietary)
- `bloom-scroll` - Slow Web Aggregator (MPL 2.0)

**Layer 3 - Stem (Core Logic):**
- `geom-core` - Geometry Library (MPL 2.0)
- `avala` - Learning Verification (AGPL v3)

**Layer 4 - Fruit (Applications):**
- `sim4d` - Web CAD (MPL 2.0)
- `forj` - Fabrication Marketplace (Proprietary)
- `digifab-quoting` - Quoting Engine (Proprietary)
- `dhanam` - Finance Platform (AGPL v3)
- `coforma-studio` - Customer Feedback (Proprietary)
- `electrochem-sim` - Galvana Platform (MPL 2.0)

**Supporting:**
- `solarpunk-foundry` - Governance & Orchestration
- `madfam-site` - Corporate Website
- `primavera3d` - Factory Portfolio

---

## Deployment Sequence

Per the manifesto, we follow strict ordering:

### Phase 1: Foundation (Current Phase)
```
1. Enclii      → Bare-metal infrastructure
2. Janua       → SSO + Revenue management
3. Dhanam      → Internal financial tracking
4. Coforma     → Waitlist/feedback capture
```

### Phase 2: Intelligence
```
5. Fortuna     → Market signal scraping
6. ForgeSight  → Cost data scraping
7. BlueprintTube → 3D model indexing
8. BloomScroll → Community building
```

### Phase 3: Core Engines
```
9. geom-core   → Publish geometry library
10. AVALA      → Verification platform
11. Sim4D      → CAD editor (alpha)
```

### Phase 4: Commerce
```
12. Cotiza     → Pricing engine
13. Forj       → Marketplace
14. Sim4D      → CAD editor (beta)
```

### Phase 5: Frontier
```
15. Galvana    → Electrochemistry (when revenue stable)
```

---

## Shared Infrastructure

All services connect via `madfam-shared-network`:

| Service | Container | Port | Purpose |
|---------|-----------|------|---------|
| PostgreSQL | madfam-postgres-shared | 5432 | Primary database |
| Redis | madfam-redis-shared | 6379 | Caching, sessions |
| MinIO | madfam-minio-shared | 9000/9001 | Object storage |

**Redis Database Allocation:**
- DB 0: Janua (sessions)
- DB 1: Forgesight (cache)
- DB 2: Digifab-quoting (cache)
- DB 3: Dhanam (cache)
- DB 4: Sim4D (collaboration)
- DB 5-7: Reserved

---

## Package Strategy

### Published to npm
- `@madfam/core` - Organizational constants (brand, locales, currencies, events, products, legal)

### Not Published (Internal)
- Each app owns its own UI components (shadcn/tailwind)
- Each app owns its own analytics implementation
- Each app owns its own config

### Anti-Patterns Avoided
- ❌ No shared UI packages across repos
- ❌ No shared "config" packages
- ❌ No cross-repo npm dependencies
- ❌ No private npm registry (Verdaccio)

### Patterns Used
- ✅ HTTP APIs as contracts between services
- ✅ Each service owns its dependencies completely
- ✅ Templates in solarpunk-foundry for reference implementations
- ✅ `@madfam/core` for organizational decisions only

---

## Local Development

```bash
# Start shared infrastructure
cd solarpunk-foundry
docker compose up -d

# Start a specific service
cd ../janua
pnpm install
pnpm dev

# Or use the madfam CLI
./madfam start        # Core ecosystem
./madfam full         # Full ecosystem
./madfam status       # Check status
./madfam stop         # Stop all
```

---

## Next Steps (When Server Ready)

1. **Deploy Enclii** on Hetzner bare-metal
2. **Configure DNS** for all domains
3. **Deploy Janua** with production secrets
4. **Migrate** local docker-compose to production
5. **Enable HTTPS** via Let's Encrypt
6. **Deploy remaining services** per sequence

---

## Documentation Index

| Document | Purpose |
|----------|---------|
| `README.md` | Manifesto & architecture |
| `docs/PORT_ALLOCATION.md` | Service port assignments |
| `docs/DOGFOODING_GUIDE.md` | Internal usage patterns |
| `docs/JANUA_INTEGRATION.md` | Auth integration guide |
| `packages/core/README.md` | @madfam/core usage |
| `templates/README.md` | Reference implementations |

---

*This roadmap reflects actual ecosystem state. Updated manually after significant changes.*
