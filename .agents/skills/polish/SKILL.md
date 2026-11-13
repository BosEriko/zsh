---
name: polish
description: Design, build, and review polished, production-quality web interfaces that are mobile-first, responsive, accessible, and free of generic AI-generated aesthetics. Use when creating, modifying, redesigning, or reviewing frontend pages, layouts, and components.
---

# Frontend Design

## When to Use

Use this skill whenever:

- Creating, redesigning, or polishing webpages, components, dashboards, landing pages, or application interfaces.
- Implementing layouts, navigation, forms, or modals.
- Reviewing or refactoring existing UI.
- Fixing responsive design issues.
- Adding features that affect the user interface.

## Goal

Create interfaces that feel intentionally designed by a skilled human designer, rather than assembled from common AI-generated templates.

Prioritize:

- visual hierarchy
- spacing and rhythm
- typography
- usability
- consistency
- responsive, mobile-first design
- accessibility
- subtle interaction
- personality appropriate to the product

The goal is not to make websites look unusual. The goal is to make them look deliberate, memorable, and appropriate for their audience.

## Before Designing

Inspect the existing application, design system, and brand guidelines first.

Determine:

- framework and styling system
- existing components
- design tokens
- fonts
- colors
- spacing conventions
- responsive patterns
- reusable layouts

Reuse existing patterns when they are good. Preserve the project's existing design system and visual identity.

Do not introduce a new UI library unless necessary.

## Design Process

1. Understand the purpose of the page.
2. Identify the primary user action.
3. Determine the information hierarchy.
4. Identify repetitive or generic design patterns in the existing UI.
5. Choose an appropriate visual direction.
6. Plan the page structure, starting from mobile.
7. Implement the design while preserving functionality.
8. Validate the rendered result at mobile, tablet, and desktop sizes.
9. Polish spacing, typography, alignment, and interaction states.
10. Check accessibility and consistency.
11. Explain the design decisions.

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

- gradients, especially default purple/blue ones
- glowing elements
- glassmorphism
- huge hero text
- rounded cards everywhere
- nested cards
- repetitive three-column card grids
- excessive shadows
- pill-shaped containers
- decorative badges
- unnecessary statistics
- generic purple/blue color palettes

Do not put every section inside a card.

Use whitespace, typography, alignment, borders, and grouping before introducing containers.

Do not blindly remove gradients, cards, shadows, or rounded corners. These are valid design tools. Remove them only when they are unnecessary, repetitive, or inconsistent with the intended visual identity.

## Content

- Avoid generic AI marketing language.
- Use specific, product-relevant headings.
- Prefer authentic product screenshots and meaningful visuals.
- Never invent testimonials, metrics, or customer logos.

## Layout

- Design mobile-first, then progressively enhance for larger screens.
- Do not simply compress the desktop layout onto mobile screens.
- Establish strong visual hierarchy.
- Use varied compositions when appropriate.
- Use consistent components without making every section identical.
- Prevent unintended horizontal scrolling.
- Use flexible layouts with CSS Grid and Flexbox.
- Avoid fixed widths that exceed the viewport.
- Stack content vertically when horizontal space becomes insufficient.
- Ensure cards, tables, and navigation adapt gracefully.
- Use appropriate maximum widths for readable content.
- Respect mobile safe areas when applicable.
- Prefer responsive units such as rem, %, min(), max(), and clamp().
- Consider content priority on small screens.

## Typography

Typography should establish hierarchy and be a defining part of the design.

- Select fonts based on the brand's personality.
- Avoid relying exclusively on generic font combinations.
- Use deliberate type scales and line heights.
- Use deliberate differences between page titles, section headings, body text, metadata, labels, and secondary information.
- Avoid making everything the same weight and size.
- Use a minimum of 16px for primary body text unless the design requires otherwise.
- Use fluid typography when appropriate.
- Prevent headings from overflowing their containers.
- Keep line lengths readable.
- Ensure comfortable line height and paragraph spacing.

## Spacing

Use a consistent spacing system.

Prefer generous, meaningful whitespace over visual clutter or excessive decoration.

Related elements should be visually grouped.

Unrelated sections should have clearly larger separation.

Avoid arbitrary spacing values when the project's spacing scale can be used.

## Color

Use a restrained, coherent palette.

Colors should have semantic or visual purpose.

Ensure sufficient contrast.

Use accent colors selectively to guide attention.

Do not use multiple competing accent colors without a reason.

Use gradients only when they serve the visual direction.

## Components

Prefer simple components with strong composition and purposeful details over decoration.

Avoid unnecessary cards, borders, and shadows.

Buttons should have clear hierarchy:

- primary
- secondary
- destructive when necessary

Interactive elements must visually communicate that they are interactive.

## Forms

- Use visible, understandable labels.
- Provide useful validation and display errors clearly.
- Provide clear focus states.
- Use appropriate input sizes, input types, and autocomplete attributes.
- Ensure inputs remain usable with mobile keyboards.
- Ensure buttons remain accessible when the keyboard is visible.
- Prevent forms from overflowing the viewport.
- Avoid unnecessary multi-column forms on mobile.

## Navigation

- Ensure navigation remains usable on small screens.
- Collapse or restructure navigation when necessary.
- Keep primary actions discoverable.
- Avoid overcrowded headers.
- Ensure mobile menus can be opened and dismissed easily.
- Prevent navigation overlays from obscuring essential content.

## Touch Interaction

- Aim for touch targets of at least 44x44 CSS pixels.
- Provide sufficient spacing between interactive elements.
- Never rely exclusively on hover interactions.
- Ensure dropdowns, menus, and dialogs work with touch.
- Avoid accidental interactions caused by overlapping elements.
- Provide visible feedback for interactive states.

## Images and Media

- Use responsive images.
- Preserve appropriate aspect ratios.
- Prevent images and videos from overflowing.
- Avoid unnecessary cropping of important content.
- Optimize media loading and rendering performance.
- Use lazy loading for suitable offscreen content.

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

- Use semantic HTML whenever possible.
- Support keyboard navigation.
- Provide visible focus indicators.
- Maintain sufficient color contrast.
- Provide meaningful, accessible labels for controls.
- Use ARIA only when necessary.
- Respect reduced-motion preferences.
- Avoid using color as the only indicator of meaning.
- Ensure dialogs and menus manage focus appropriately.

## Implementation

- Follow the project's existing architecture and conventions.
- Reuse existing components, design tokens, and utility classes.
- Prefer semantic HTML and simple, maintainable CSS over unnecessary abstractions or excessive overrides.
- Avoid arbitrary pixel values when existing spacing tokens are available.
- Keep responsive behavior close to the relevant component.
- Avoid introducing unnecessary dependencies.
- Do not rewrite working components purely for stylistic reasons.
- Do not modify unrelated UI.
- Do not introduce regressions at desktop sizes.
- Avoid unnecessary explanatory comments in code.

## Responsive Validation

Verify the rendered interface instead of relying only on CSS inspection. Never consider frontend work complete without responsive validation.

Test at the following viewport widths:

| Width | Device |
|---|---|
| 320px | Small mobile |
| 375px | Standard mobile |
| 390px | Modern mobile |
| 430px | Large mobile |
| 768px | Tablet |
| 1024px | Small desktop |
| 1440px | Desktop |

Use content-driven breakpoints rather than hardcoding device-specific behavior.

When browser automation or Playwright is available:

1. Start the application locally.
2. Open the affected pages.
3. Test all required viewport widths.
4. Capture screenshots of relevant pages and states.
5. Inspect screenshots for visual defects.
6. Check for horizontal overflow.
7. Test navigation and interactive elements.
8. Fix identified issues.
9. Repeat until validation passes.

Test relevant UI states, including:

- Default state.
- Loading state.
- Empty state.
- Error state.
- Hover, focus, and disabled states.
- Open navigation menus.
- Open dialogs.
- Forms with validation errors.
- Long text and overflowing content.

### Horizontal Overflow Check

Use the following browser-side check:

```js
const hasHorizontalOverflow = await page.evaluate(() => {
  return (
    document.documentElement.scrollWidth >
    document.documentElement.clientWidth
  );
});

if (hasHorizontalOverflow) {
  throw new Error("Horizontal overflow detected");
}
```

Investigate the actual overflowing element instead of hiding the problem with `overflow-x: hidden`.

## Final Design Review

Before declaring the work complete, inspect the page as a designer.

Check:

- Does the interface resemble a generic AI-generated SaaS template?
- Is the hierarchy obvious?
- Is anything unnecessarily boxed?
- Are there unnecessary gradients, shadows, or rounded cards?
- Is spacing consistent and are proportions balanced?
- Are alignments precise?
- Is typography distinctive, intentional, and readable?
- Are colors restrained, with consistent border radii and shadows?
- Is the design consistent without being repetitive?
- Does the website communicate a recognizable identity?
- Does mobile feel designed rather than adapted?
- Are there any clipped, overlapping, or awkwardly positioned elements?
- Are hover, focus, and disabled states handled?
- Is the interface accessible and usable?

Do not assume a technically responsive layout is visually polished. Fix these issues before finishing.

## Completion Criteria

Frontend work is complete only when:

- [ ] Mobile layouts are visually polished.
- [ ] Tablet and desktop layouts remain functional.
- [ ] No unintended horizontal overflow exists.
- [ ] Text remains readable at all tested widths.
- [ ] Interactive elements are touch-friendly.
- [ ] Navigation works on mobile.
- [ ] Forms and dialogs fit within the viewport.
- [ ] Images and media scale correctly.
- [ ] Accessibility requirements are respected.
- [ ] Existing design conventions are preserved.
- [ ] Responsive tests pass.
- [ ] Visual screenshots have been inspected when tooling is available.

If browser testing is unavailable, explicitly report that visual validation was not performed. Never claim tests passed without executing them.

## Final Reporting

When completing frontend work, briefly report:

1. What UI was changed.
2. What design decisions were made and why.
3. What responsive improvements were made.
4. Which viewport sizes were tested.
5. Whether visual inspection was performed.
6. Any remaining issues or limitations.

Do not mark the task as fully verified when responsive or visual testing could not be completed.
