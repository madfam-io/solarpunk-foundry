import { forwardRef, type ButtonHTMLAttributes } from 'react'
import { Slot } from '@radix-ui/react-slot'
import { cva, type VariantProps } from 'class-variance-authority'
import { cn } from '../lib/utils'

/**
 * Button component with φ-based golden ratio design system
 * Supports multiple variants, sizes, and shimmer effects
 */
const buttonVariants = cva(
  'inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-2xl text-sm font-medium ring-offset-background transition-all duration-300 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50',
  {
    variants: {
      variant: {
        default: 'bg-gradient-to-b from-amber-300 to-amber-500 text-neutral-900 hover:shadow-lg hover:shadow-amber-500/20 hover:scale-105 active:scale-100',
        secondary: 'bg-neutral-800/50 backdrop-blur-sm border border-neutral-700/50 text-neutral-100 hover:bg-neutral-700/50',
        outline: 'border border-amber-500/50 bg-transparent text-amber-500 hover:bg-amber-500/10',
        ghost: 'bg-transparent text-neutral-300 hover:bg-neutral-800/50 hover:text-neutral-100',
        destructive: 'bg-red-600 text-neutral-100 hover:bg-red-700',
        link: 'text-amber-500 underline-offset-4 hover:underline p-0 h-auto',
      },
      size: {
        default: 'h-11 px-6 py-2',
        sm: 'h-9 px-4 py-1.5 text-xs',
        lg: 'h-12 px-8 py-3 text-base',
        icon: 'h-11 w-11 p-0',
      },
      shimmer: {
        true: 'relative overflow-hidden',
        false: '',
      },
    },
    defaultVariants: {
      variant: 'default',
      size: 'default',
      shimmer: false,
    },
  }
)

export interface ButtonProps
  extends ButtonHTMLAttributes<HTMLButtonElement>,
    VariantProps<typeof buttonVariants> {
  asChild?: boolean
}

const Button = forwardRef<HTMLButtonElement, ButtonProps>(
  ({ className, variant, size, shimmer, asChild = false, children, ...props }, ref) => {
    const Comp = asChild ? Slot : 'button'

    if (asChild) {
      return (
        <Comp
          className={cn(buttonVariants({ variant, size, shimmer }), className)}
          ref={ref}
          {...props}
        >
          {children}
        </Comp>
      )
    }

    return (
      <Comp
        className={cn(buttonVariants({ variant, size, shimmer }), className)}
        ref={ref}
        {...props}
      >
        {children}
        {Boolean(shimmer) && variant === 'default' && (
          <span className="absolute inset-0 rounded-2xl opacity-0 hover:opacity-100 bg-gradient-to-r from-transparent via-white/20 to-transparent -translate-x-full hover:translate-x-full transition-all duration-700" />
        )}
      </Comp>
    )
  }
)
Button.displayName = 'Button'

export { Button, buttonVariants }
