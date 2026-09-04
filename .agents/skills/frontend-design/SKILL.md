---
name: frontend-design
description: Design and improve polished, production-quality web interfaces.
---

# Frontend Design

Use this skill when creating, redesigning, or polishing webpages,
components, dashboards, landing pages, or application interfaces.

## Goal

Create interfaces that feel intentionally designed rather than
AI-generated.

Prioritize:

- visual hierarchy
- spacing and rhythm
- typography
- usability
- consistency
- responsive design
- accessibility
- subtle interaction
- personality appropriate to the product

## Before Designing

Inspect the existing application first.

Determine:

- framework and styling system
- existing components
- design tokens
- fonts
- colors
- spacing conventions
- responsive patterns
- reusable layouts

Reuse existing patterns when they are good.

Do not introduce a new UI library unless necessary.

## Design Process

Before implementing:

1. Understand the purpose of the page.
2. Identify the primary user action.
3. Determine the information hierarchy.
4. Choose an appropriate visual direction.
5. Plan the page structure.
6. Implement the design.
7. Review the result at desktop and mobile sizes.
8. Polish spacing, typography, alignment, and interaction states.

## Visual Direction

Choose a clear visual direction appropriate to the product.

Examples:

- minimal
- editorial
- playful
- utilitarian
- futuristic
- retro
- developer-tool
- premium
- cozy
- brutalist

Do not automatically default to a SaaS dashboard aesthetic.

The interface should have a recognizable visual identity.

## Avoid Generic AI Design

Avoid excessive use of:

- gradients
- glowing elements
- glassmorphism
- huge hero text
- rounded cards everywhere
- nested cards
- excessive shadows
- pill-shaped containers
- decorative badges
- unnecessary statistics
- generic purple/blue color palettes

Do not put every section inside a card.

Use whitespace, typography, alignment, borders, and grouping before
introducing containers.

## Typography

Typography should establish hierarchy.

Use deliberate differences between:

- page titles
- section headings
- body text
- metadata
- labels
- secondary information

Avoid making everything the same weight and size.

Keep line lengths readable.

## Spacing

Use a consistent spacing system.

Prefer generous whitespace over visual clutter.

Related elements should be visually grouped.

Unrelated sections should have clearly larger separation.

Avoid arbitrary spacing values when the project's spacing scale can
be used.

## Color

Use a restrained palette.

Colors should have semantic or visual purpose.

Ensure sufficient contrast.

Use accent colors selectively to guide attention.

Do not use multiple competing accent colors without a reason.

## Components

Prefer simple components with strong composition.

Buttons should have clear hierarchy:

- primary
- secondary
- destructive when necessary

Forms should have:

- visible labels
- useful validation
- clear focus states
- appropriate input sizes

Interactive elements must visually communicate that they are
interactive.

## Responsive Design

Design for both desktop and mobile.

Do not simply shrink the desktop layout.

Consider:

- stacking
- navigation changes
- readable widths
- touch targets
- spacing
- overflow
- content priority

## Interaction

Use motion sparingly.

Good uses:

- hover feedback
- focus transitions
- expanding content
- navigation transitions
- state changes

Avoid animation that delays interaction.

## Accessibility

Use semantic HTML whenever possible.

Ensure:

- keyboard accessibility
- visible focus states
- sufficient contrast
- meaningful labels
- appropriate ARIA only when necessary
- reduced-motion compatibility where relevant

## Implementation

Follow the project's existing architecture.

Prefer:

- reusable components
- semantic HTML
- existing design tokens
- existing utility classes
- simple CSS over unnecessary abstractions

Do not rewrite working components purely for stylistic reasons.

## Final Design Review

Before declaring the work complete, inspect the page as a designer.

Check:

- Is the hierarchy obvious?
- Is anything unnecessarily boxed?
- Is spacing consistent?
- Are alignments precise?
- Is typography intentional?
- Are colors restrained?
- Does mobile feel designed rather than adapted?
- Are hover/focus/disabled states handled?
- Does anything look like generic AI-generated UI?

Fix these issues before finishing.
