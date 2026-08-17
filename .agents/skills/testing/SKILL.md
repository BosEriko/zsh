---
name: testing
description: Create, update, and run tests for code changes. Use when asked to add tests, fix failing tests, improve test coverage, or verify behavior with tests.
---

# Testing

## Workflow

1. Identify the behavior being changed.
2. Find existing tests for similar behavior.
3. Follow existing testing conventions.
4. Add the smallest tests necessary.
5. Run the relevant tests.
6. Fix failures caused by the change.
7. Run the broader test suite when appropriate.

## Rules

- Test behavior, not implementation details.
- Prefer existing test utilities and factories.
- Include failure and edge cases where meaningful.
- Do not modify production behavior merely to make a test pass.
