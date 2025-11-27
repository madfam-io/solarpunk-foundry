# @madfam/ui

Solarpunk design system with φ-based golden ratio proportions and glassmorphism aesthetics.

## Installation

```bash
pnpm add @madfam/ui
```

## Peer Dependencies

```bash
pnpm add react react-dom tailwindcss
```

## Setup

### 1. Add Tailwind Preset

```js
// tailwind.config.js
module.exports = {
  presets: [require('@madfam/ui/tailwind.preset')],
  content: [
    './src/**/*.{js,ts,jsx,tsx}',
    './node_modules/@madfam/ui/**/*.{js,ts,jsx,tsx}',
  ],
}
```

### 2. Import Components

```tsx
import { Button, Card, GlassPanel } from '@madfam/ui'
```

## Components

### Button

Golden ratio styled button with multiple variants.

```tsx
<Button variant="default">Primary Action</Button>
<Button variant="secondary">Secondary</Button>
<Button variant="outline">Outlined</Button>
<Button variant="ghost">Ghost</Button>
<Button variant="destructive">Delete</Button>
<Button variant="link">Link Style</Button>

// Sizes
<Button size="sm">Small</Button>
<Button size="default">Default</Button>
<Button size="lg">Large</Button>
<Button size="icon"><IconComponent /></Button>

// With shimmer effect
<Button shimmer>Shimmer Effect</Button>

// As child (polymorphic)
<Button asChild>
  <a href="/somewhere">Link Button</a>
</Button>
```

### Card

Glassmorphism card with flexible composition.

```tsx
<Card variant="default">
  <CardHeader>
    <CardTitle>Card Title</CardTitle>
    <CardDescription>Card description text</CardDescription>
  </CardHeader>
  <CardContent>
    Content goes here
  </CardContent>
  <CardFooter>
    <Button>Action</Button>
  </CardFooter>
</Card>

// Variants
<Card variant="elevated">Elevated with shadow</Card>
<Card variant="outline">Outlined style</Card>
<Card variant="ghost">Transparent background</Card>
<Card variant="gold">Golden accent</Card>

// Interactive
<Card interactive onClick={handleClick}>
  Clickable card with hover effects
</Card>
```

### GlassPanel

Advanced glassmorphism panel with decorative elements.

```tsx
<GlassPanel>Basic glass panel</GlassPanel>

// Variants
<GlassPanel variant="subtle">Subtle blur</GlassPanel>
<GlassPanel variant="strong">Strong blur</GlassPanel>
<GlassPanel variant="gold">Gold accent</GlassPanel>
<GlassPanel variant="electric">Blue accent</GlassPanel>

// Glow effects
<GlassPanel glow="soft">Soft glow</GlassPanel>
<GlassPanel glow="medium">Medium glow</GlassPanel>
<GlassPanel glow="strong">Strong glow</GlassPanel>

// Decorative elements
<GlassPanel withTopGradient>Top gradient line</GlassPanel>
<GlassPanel withFloatingElements>Floating orbs</GlassPanel>
```

## Utilities

### cn() - Class Name Merger

```tsx
import { cn } from '@madfam/ui'

<div className={cn('base-class', isActive && 'active-class', className)} />
```

### PHI Constants

```tsx
import { PHI, phiScale, phiSpacing } from '@madfam/ui'

// PHI = 1.618033988749895

// Scale a value by phi
const scaled = phiScale(16, 2)  // 16 * φ² = 41.88

// Generate spacing object for Tailwind
const spacing = phiSpacing(4, 8)  // { 'phi-0': '1.528px', 'phi-1': '2.472px', ... }
```

## Design Tokens

### Colors

- **gold-***: Amber/gold palette for primary accents
- **electric-***: Blue palette for secondary accents
- **neutral-***: Gray scale for backgrounds and text

### Shadows

- **aureo-1**: Subtle shadow with gold tint
- **aureo-2**: Medium shadow with gold tint
- **aureo-3**: Strong shadow with gold tint
- **glass**: Standard glassmorphism shadow

### Spacing (φ-based)

- **phi-0** through **phi-10**: Exponentially scaled spacing using golden ratio

### Animation

- **float**: Gentle floating animation
- **shimmer**: Button shimmer effect
- **glow-pulse**: Pulsing glow effect

## License

MIT
