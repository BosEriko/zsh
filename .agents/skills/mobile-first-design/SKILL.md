---
name: mobile-first-design
description: Ensure all frontend interfaces are responsive, visually polished, accessible, and optimized for mobile devices. Use when creating, modifying, or reviewing frontend pages, layouts, and components.
---

# Mobile-First Design

## When to Use

Invoke this skill whenever:
- Creating or modifying frontend pages or components.
- Implementing layouts, navigation, forms, or modals.
- Reviewing or refactoring existing UI.
- Fixing responsive design issues.
- Adding features that affect the user interface.

## Core Principles

1. Design mobile-first, then progressively enhance for larger screens.
2. Preserve the project's existing design system and visual identity.
3. Prioritize usability, readability, and visual consistency.
4. Avoid desktop layouts simply being compressed onto mobile screens.
5. Verify the rendered interface instead of relying only on CSS inspection.
6. Never consider frontend work complete without responsive validation.

## Responsive Breakpoints

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

## Layout Requirements

- Prevent unintended horizontal scrolling.
- Use flexible layouts with CSS Grid and Flexbox.
- Avoid fixed widths that exceed the viewport.
- Maintain consistent spacing and alignment.
- Stack content vertically when horizontal space becomes insufficient.
- Ensure cards, tables, and navigation adapt gracefully.
- Use appropriate maximum widths for readable content.
- Respect mobile safe areas when applicable.
- Prefer responsive units such as rem, %, min(), max(), and clamp().

## Typography

- Maintain readable text sizes across all devices.
- Use a minimum of 16px for primary body text unless the design requires otherwise.
- Use fluid typography when appropriate.
- Maintain clear visual hierarchy.
- Prevent headings from overflowing their containers.
- Avoid excessive line lengths.
- Ensure comfortable line height and paragraph spacing.

## Touch Interaction

- Aim for touch targets of at least 44x44 CSS pixels.
- Provide sufficient spacing between interactive elements.
- Never rely exclusively on hover interactions.
- Ensure dropdowns, menus, and dialogs work with touch.
- Avoid accidental interactions caused by overlapping elements.
- Provide visible feedback for interactive states.

## Navigation

- Ensure navigation remains usable on small screens.
- Collapse or restructure navigation when necessary.
- Keep primary actions discoverable.
- Avoid overcrowded headers.
- Ensure mobile menus can be opened and dismissed easily.
- Prevent navigation overlays from obscuring essential content.

## Forms

- Use appropriate input types and autocomplete attributes.
- Keep labels visible and understandable.
- Ensure inputs remain usable with mobile keyboards.
- Prevent forms from overflowing the viewport.
- Display validation errors clearly.
- Ensure buttons remain accessible when the keyboard is visible.
- Avoid unnecessary multi-column forms on mobile.

## Images and Media

- Use responsive images.
- Preserve appropriate aspect ratios.
- Prevent images and videos from overflowing.
- Avoid unnecessary cropping of important content.
- Optimize media loading and rendering performance.
- Use lazy loading for suitable offscreen content.

## Accessibility

- Maintain sufficient color contrast.
- Support keyboard navigation.
- Provide visible focus indicators.
- Use semantic HTML.
- Provide accessible labels for controls.
- Respect reduced-motion preferences.
- Avoid using color as the only indicator of meaning.
- Ensure dialogs and menus manage focus appropriately.

## Visual Quality

Review the interface for:

- Consistent spacing.
- Balanced proportions.
- Clear visual hierarchy.
- Proper alignment.
- Readable typography.
- Appropriate whitespace.
- Consistent border radii.
- Consistent colors and shadows.
- Attractive mobile-specific composition.
- No clipped, overlapping, or awkwardly positioned elements.

Do not assume a technically responsive layout is visually polished.

## Testing Workflow

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

## Implementation Guidelines

- Follow existing project conventions.
- Reuse existing components and design tokens.
- Avoid introducing unnecessary dependencies.
- Prefer maintainable CSS over excessive overrides.
- Avoid arbitrary pixel values when existing spacing tokens are available.
- Keep responsive behavior close to the relevant component.
- Do not modify unrelated UI.
- Do not introduce regressions at desktop sizes.
- Avoid unnecessary explanatory comments in code.

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
2. What responsive improvements were made.
3. Which viewport sizes were tested.
4. Whether visual inspection was performed.
5. Any remaining issues or limitations.

Do not mark the task as fully verified when responsive or visual testing could not be completed.
