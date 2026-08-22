---
name: testing
description: Validate completed code changes by identifying, adding, and running the smallest relevant set of tests and checks. Use after implementation changes are complete.
---

# Testing

## Workflow

1. Identify the behavior changed by the implementation.
2. Locate existing tests covering that behavior.
3. Determine whether existing tests are sufficient.
4. Add or update tests when required to validate new or changed behavior.
5. Run the most focused relevant tests first.
6. Fix failures caused by the implementation.
7. Run broader relevant tests when appropriate.
8. Run relevant type checking, linting, or build checks when appropriate.
9. Record what was run and the results.

## Rules

- Never claim a test or check passed unless it was actually run.
- Do not modify tests merely to make incorrect behavior pass.
- Test observable behavior rather than implementation details when possible.
- Follow existing testing conventions.
- Prefer focused tests before expensive broad test suites.
- Do not fix unrelated failing tests.
- Clearly distinguish failures caused by the current changes from pre-existing failures.
- Report checks that could not be run and why.
