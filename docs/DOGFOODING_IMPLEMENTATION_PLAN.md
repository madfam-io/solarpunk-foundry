# MADFAM Dogfooding Implementation Plan

**Version:** 1.0.0  
**Date:** 2025-11-25  
**Status:** 🟢 Active Execution

---

## Executive Summary

This plan transforms MADFAM from 18 isolated repositories into an interconnected ecosystem where we "eat our own dog food" - using our own tools to run our operations.

**Current State:** 1 cross-repo dependency (sim4d → geom-core)  
**Target State:** 15+ interconnections across 4 shared libraries

---

## Phase 1: Foundation (Week 1-2)

### 1A. Extract @madfam/ui as Standalone Shared Library

**Why:** Currently embedded in madfam-site. 5+ repos need shared UI components.

**Current Location:** `madfam-site/packages/ui`  
**Target Location:** `labspace/madfam-ui` (new repo)

**Components Available:**
- Button, Card, Container, Heading, Spinner
- Hero, CTA, Features, LeadForm
- MobileButton, MobileInput
- LogoSystem, BrandParticles
- Theme utilities (brand-colors, brand-bridge)

**Consumers:**
| Repo | App | Priority |
|------|-----|----------|
| sim4d | studio | P0 |
| janua | dashboard, admin | P1 |
| forgesight | web | P1 |
| digifab-quoting | web | P2 |
| dhanam | web | P2 |

**Implementation Steps:**
```bash
# 1. Create new repo
mkdir labspace/madfam-ui
cd labspace/madfam-ui
git init

# 2. Copy package contents
cp -r ../madfam-site/packages/ui/* .

# 3. Update package.json for standalone
# - Add publishConfig for npm/private registry
# - Update peer dependencies
# - Add repository field

# 4. Update madfam-site to consume from file:../madfam-ui
# 5. Wire first consumer (sim4d/studio)
```

**Success Criteria:**
- [ ] madfam-ui builds independently
- [ ] madfam-site consumes from file:../madfam-ui
- [ ] sim4d/studio imports @madfam/ui components
- [ ] No duplicate UI code across repos

---

### 1B. Create @madfam/tsconfig Shared Configs

**Why:** 11 turbo monorepos with inconsistent TypeScript configurations.

**Target Location:** `labspace/madfam-configs` (new repo)

**Configs to Provide:**
```
@madfam/tsconfig
├── base.json           # Shared strict settings
├── react.json          # React app settings
├── node.json           # Node.js/backend settings
├── library.json        # Publishable package settings
└── next.json           # Next.js specific
```

**Consumers:** All 11 turbo monorepos

**Implementation Steps:**
```bash
# 1. Create configs repo
mkdir labspace/madfam-configs
cd labspace/madfam-configs

# 2. Create base tsconfig with MADFAM standards
# 3. Create framework-specific extends
# 4. Wire to first consumer (sim4d)
# 5. Gradually migrate other repos
```

**Success Criteria:**
- [ ] All repos extend @madfam/tsconfig/base
- [ ] Consistent strictness across ecosystem
- [ ] Single source of truth for TS standards

---

### 1C. Wire Janua SSO to Consumer Apps

**Why:** Janua is our identity layer. Currently no apps consume @janua/react-sdk.

**SDK Available:** `@janua/react-sdk`
- JanuaProvider
- useAuth, useSession, useOrganization hooks
- SignIn, SignUp, UserProfile components

**First Consumer:** sim4d/studio (highest traffic)

**Implementation Steps:**
```bash
# 1. Add dependency to sim4d/apps/studio
pnpm add @janua/react-sdk@file:../../janua/packages/react-sdk

# 2. Wrap app with JanuaProvider
# 3. Replace any existing auth with Janua hooks
# 4. Configure Janua API URL in environment
```

**Success Criteria:**
- [ ] sim4d/studio authenticates via Janua
- [ ] Single sign-on works across MADFAM apps
- [ ] User profile synced from Janua

---

## Phase 2: Internal Operations (Week 3-4)

### 2A. Dhanam for MADFAM Finance

**Why:** "We run on our own tools" - Primavera Mandate

**Current State:** Dhanam exists but MADFAM doesn't use it internally.

**Integration Points:**
- Expense tracking for MADFAM operations
- Revenue from each product line
- ESG reporting for sustainability metrics

**Implementation:**
- Configure MADFAM as organization in Dhanam
- Import historical financial data
- Dashboard for real-time financial health

---

### 2B. digifab-quoting → Primavera3D

**Why:** Our factory should quote using our own quoting engine.

**Current State:** Separate systems, no integration.

**Integration:**
- Primavera3D uploads designs
- digifab-quoting returns instant quotes
- Shared pricing database from ForgeSight

---

### 2C. @madfam/analytics Extraction

**Why:** Currently in madfam-site, should be ecosystem-wide.

**Current Location:** `madfam-site/packages/analytics`

**Integration:** All web apps report to unified analytics.

---

## Phase 3: Full Ecosystem (Week 5-8)

### 3A. Fortuna → Product Strategy

**Why:** Build what Fortuna validates (problem intelligence).

**Integration:**
- Fortuna identifies market gaps
- Product decisions backed by data
- Feature prioritization from real signals

---

### 3B. AVALA → Team Certification

**Why:** Staff certified via our own verification engine.

**Integration:**
- Team skills tracked in AVALA
- DC-3 forms for Mexican compliance
- Open Badges for achievements

---

### 3C. ForgeSight → digifab-quoting

**Why:** Real-time material pricing from our own scraper.

**Integration:**
- ForgeSight provides cost data
- digifab-quoting uses for quotes
- Dynamic pricing based on market

---

### 3D. Coforma → All Products

**Why:** Centralized feedback collection.

**Integration:**
- Coforma embedded in all apps
- Customer advisory board data
- Feature requests centralized

---

## Dependency Graph (Target State)

```
                    ┌─────────────────────────────────────────┐
                    │         SOLARPUNK-FOUNDRY               │
                    │    (governance, orchestration, docs)    │
                    └────────────────────┬────────────────────┘
                                         │
        ┌────────────────────────────────┼────────────────────────────────┐
        │                                │                                │
        ▼                                ▼                                ▼
┌───────────────┐              ┌─────────────────┐              ┌─────────────────┐
│ SHARED LIBS   │              │   SOIL LAYER    │              │   STEM LAYER    │
│               │              │                 │              │                 │
│ @madfam/ui    │◀────────────▶│ Janua (identity)│◀────────────▶│ geom-core       │
│ @madfam/config│              │ Enclii (infra)  │              │ AVALA (verify)  │
│ @madfam/analytics            └────────┬────────┘              └────────┬────────┘
└───────┬───────┘                       │                                │
        │                               │ SSO                            │ geometry
        │ UI                            │                                │
        │                               ▼                                ▼
        │              ┌────────────────────────────────────────────────────────────┐
        └─────────────▶│                    FRUIT LAYER                             │
                       │                                                            │
                       │  ┌─────────┐    ┌──────────────┐    ┌─────────┐           │
                       │  │  sim4d  │◀──▶│digifab-quoting│◀──▶│Primavera│           │
                       │  └────┬────┘    └──────┬───────┘    └─────────┘           │
                       │       │                │                                   │
                       │       │         ┌──────▼───────┐                          │
                       │       │         │  ForgeSight  │ (pricing data)           │
                       │       │         └──────────────┘                          │
                       │       │                                                   │
                       │  ┌────▼────┐    ┌─────────┐    ┌─────────┐               │
                       │  │ Dhanam  │    │  Forj   │    │ Coforma │               │
                       │  │(finance)│    │ (bazaar)│    │(feedback)│               │
                       │  └─────────┘    └─────────┘    └─────────┘               │
                       └────────────────────────────────────────────────────────────┘
```

---

## Implementation Order

| Step | Task | Dependencies | Effort |
|------|------|--------------|--------|
| 1 | Extract @madfam/ui to standalone repo | None | 2h |
| 2 | Wire @madfam/ui to madfam-site | Step 1 | 1h |
| 3 | Wire @madfam/ui to sim4d/studio | Step 1 | 2h |
| 4 | Create @madfam/tsconfig repo | None | 1h |
| 5 | Wire Janua SDK to sim4d/studio | None | 3h |
| 6 | Wire Janua SDK to other apps | Step 5 | 4h |
| 7 | Configure Dhanam for MADFAM ops | None | 4h |
| 8 | digifab-quoting ↔ Primavera3D | None | 6h |

---

## Success Metrics

| Metric | Current | Phase 1 | Phase 2 | Phase 3 |
|--------|---------|---------|---------|---------|
| Cross-repo deps | 1 | 5 | 10 | 15+ |
| Shared libraries | 1 | 3 | 4 | 5 |
| Apps using Janua SSO | 0 | 2 | 5 | 8+ |
| Internal tool usage | 10% | 30% | 60% | 90% |

---

## Risk Mitigation

| Risk | Mitigation |
|------|------------|
| Breaking changes in shared libs | Semantic versioning, changelogs |
| Circular dependencies | Clear layer architecture (Soil→Stem→Fruit) |
| Build complexity | Turbo caching, incremental builds |
| Version drift | Renovate bot for dependency updates |

---

## Next Actions

1. **Today:** Create madfam-ui repo, extract from madfam-site
2. **Today:** Wire @madfam/ui to sim4d/studio
3. **Tomorrow:** Add Janua SDK to sim4d/studio
4. **This week:** Complete Phase 1

---

*Document maintained in solarpunk-foundry as single source of truth.*
