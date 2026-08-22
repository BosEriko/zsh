---
name: task-verification
description: Verify that a completed implementation satisfies the original development task, requirements, and acceptance criteria. Use as the final step before declaring a task complete.
---

# Task Verification

## Workflow

1. Re-read the original task.
2. Review the requirements identified during task analysis.
3. Review every explicit acceptance criterion.
4. Review any inferred acceptance criteria separately.
5. Inspect the final implementation and diff.
6. Review test and validation results.
7. Map each requirement and acceptance criterion to evidence in the implementation or tests.
8. Identify anything incomplete, partially implemented, or unverified.
9. Determine whether the task can be considered complete.

## Output

Provide a final verification summary containing:

- Implementation summary
- Files changed
- Tests and checks performed
- Acceptance criteria status
- Unresolved items, if any
- Final status: Complete or Incomplete

For acceptance criteria, use:

- PASS — satisfied and verified
- PARTIAL — partially satisfied
- FAIL — not satisfied
- UNVERIFIED — implementation may exist but could not be validated

## Rules

- Verification is against the original task, not merely the implementation plan.
- Do not mark a requirement as passing solely because tests pass.
- Do not mark tests as passing unless they were actually run.
- Keep explicit and inferred acceptance criteria distinguishable.
- Do not hide incomplete work.
- Do not declare the task complete when a required criterion is FAIL or PARTIAL.
- Treat materially important UNVERIFIED criteria as incomplete unless there is sufficient evidence to justify completion.
