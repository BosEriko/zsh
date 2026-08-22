---
name: task-planning
description: Create a concrete implementation plan for a development task based on the task requirements and repository exploration. Use after task analysis and codebase exploration and before implementation.
---

# Task Planning

## Workflow

1. Review the task requirements and acceptance criteria.
2. Review findings from codebase exploration.
3. Determine the smallest implementation that satisfies the task.
4. Break the implementation into sequential steps.
5. Identify the files affected by each step.
6. Include required tests or test updates.
7. Account for error handling, edge cases, and compatibility when relevant.
8. Check that every acceptance criterion is covered by the plan.

## Output

Provide:

- Implementation approach
- Estimated files to change
- Sequential implementation steps
- Testing approach
- Risks or assumptions, if any

Keep implementation steps flat and actionable.

## Rules

- Do not implement code while planning.
- Avoid speculative changes.
- Prefer modifying existing abstractions over creating new ones when appropriate.
- Do not include unrelated refactoring.
- Every planned change must contribute to a requirement, acceptance criterion, test, or necessary supporting behavior.
- Call out blockers rather than silently designing around missing requirements.
