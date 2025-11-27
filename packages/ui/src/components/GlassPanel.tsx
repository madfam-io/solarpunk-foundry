import { forwardRef, type HTMLAttributes } from 'react'
import { cva, type VariantProps } from 'class-variance-authority'
import { cn } from '../lib/utils'

/**
 * GlassPanel component with advanced glassmorphism effects
 * Supports glows, gradients, and floating decorative elements
 */
const glassPanelVariants = cva(
  'relative overflow-hidden transition-all duration-300',
  {
    variants: {
      variant: {
        default: 'bg-neutral-900/50 backdrop-blur-md border border-neutral-700/50',
        subtle: 'bg-neutral-950/30 backdrop-blur-sm border border-neutral-700/30',
        strong: 'bg-neutral-900/60 backdrop-blur-lg border border-neutral-600/40 shadow-lg shadow-black/30',
        gold: 'bg-neutral-900/50 backdrop-blur-md border border-amber-500/20 shadow-lg shadow-amber-500/10',
        electric: 'bg-neutral-900/50 backdrop-blur-md border border-blue-500/20 shadow-lg shadow-blue-500/10',
      },
      size: {
        sm: 'p-4 rounded-lg',
        default: 'p-6 rounded-2xl',
        lg: 'p-8 rounded-3xl',
      },
      glow: {
        none: '',
        soft: 'shadow-md shadow-amber-500/5',
        medium: 'shadow-lg shadow-amber-500/10',
        strong: 'shadow-xl shadow-amber-500/20',
      },
      interactive: {
        true: 'cursor-pointer hover:shadow-lg hover:shadow-amber-500/15 hover:-translate-y-0.5',
        false: '',
      },
    },
    defaultVariants: {
      variant: 'default',
      size: 'default',
      glow: 'none',
      interactive: false,
    },
  }
)

export interface GlassPanelProps
  extends HTMLAttributes<HTMLDivElement>,
    VariantProps<typeof glassPanelVariants> {
  /** Show top gradient accent line */
  withTopGradient?: boolean
  /** Show floating decorative elements */
  withFloatingElements?: boolean
}

const GlassPanel = forwardRef<HTMLDivElement, GlassPanelProps>(
  ({
    className,
    variant,
    size,
    glow,
    interactive,
    withTopGradient = true,
    withFloatingElements = false,
    children,
    ...props
  }, ref) => {
    return (
      <div
        ref={ref}
        className={cn(glassPanelVariants({ variant, size, glow, interactive }), className)}
        {...props}
      >
        {/* Top gradient accent */}
        {withTopGradient && (
          <div className="absolute inset-x-0 top-0 h-px bg-gradient-to-r from-transparent via-amber-300/60 to-transparent" />
        )}

        {/* Content */}
        <div className="relative z-10">
          {children}
        </div>

        {/* Floating decorative elements */}
        {withFloatingElements && (
          <>
            <div
              className="absolute -top-2 -right-2 h-4 w-4 bg-amber-500/40 rounded-full blur-sm animate-pulse"
              style={{ animationDuration: '3s' }}
            />
            <div
              className="absolute -bottom-1 -left-1 h-3 w-3 bg-blue-500/30 rounded-full blur-sm animate-pulse"
              style={{ animationDuration: '4s', animationDelay: '1s' }}
            />
          </>
        )}
      </div>
    )
  }
)
GlassPanel.displayName = 'GlassPanel'

export { GlassPanel, glassPanelVariants }
