# Development Workflow

For development tasks, follow this workflow in order:

1. Use `$task-analysis` to understand the task and establish the requirements.
2. Use `$codebase-exploration` to understand the relevant code and existing patterns.
3. Use `$task-planning` to determine the implementation approach.
4. Implement the planned changes.
5. Use `$testing` to validate the implementation.
6. Use `$code-review` to review the completed changes.
7. Use `$task-verification` to verify the implementation against the original task.

Do not skip a step unless it is clearly not applicable.

Do not declare the task complete until `$task-verification` confirms that
the implementation satisfies the requirements and acceptance criteria.

# General Rules

- Make the smallest change necessary to complete the task.
- Follow repository-specific `AGENTS.md` instructions.
- Prefer existing patterns and abstractions over introducing new ones.
- Do not modify unrelated code.
- Do not fix unrelated issues unless explicitly requested.
- Do not introduce new dependencies unless necessary.
- Do not commit changes unless explicitly requested.
- Never claim that tests, linting, builds, or other checks passed unless they were actually run.
- Clearly report anything that could not be verified.

# Code Comments

- Do not add code comments unless explicitly requested.
- Do not add comments explaining implementation details, data flow, security behavior, performance characteristics, or obvious design decisions.
- Do not add comments describing what a function, block, variable, endpoint, or operation does.
- Do not add JSDoc or documentation comments unless explicitly requested.
- Preserve existing comments unless the change makes them inaccurate.
- Prefer clear naming and self-explanatory code instead of comments.
