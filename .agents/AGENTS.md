# Development Workflow

For development tasks, follow this workflow in order:

1. Use `workflow-task-analysis` to understand the task and establish the requirements.
2. Use `workflow-codebase-exploration` to understand the relevant code and existing patterns.
3. Use `workflow-task-planning` to determine the implementation approach.
4. Implement the planned changes.
5. Use `workflow-testing` to validate the implementation.
6. Use `workflow-code-review` to review the completed changes.
7. Use `workflow-task-verification` to verify the implementation against the original task.

Do not skip a step unless it is clearly not applicable.

Do not declare the task complete until `workflow-task-verification` confirms that
the implementation satisfies the requirements and acceptance criteria.

# Subagents

When building a feature, use subagents so the work goes faster and the main conversation stays small:

- Skip separate exploration subagents when the builders can explore their own area: give each builder the plan and the contract and let it read what it needs, so the same files aren't read twice. Use an explorer only when you need the map before you can settle the plan, for example to choose between approaches across several areas.
- Implement independent parts in parallel subagents once the plan is settled, as long as they don't edit the same files. Give each one a self-contained brief: the files involved, the agreed API shape between the parts, the repository conventions to follow, and what done looks like.
- Hand checks with long output (full test suites, lint, type checks, browser or simulator screenshots) to subagents that report back only the results and any failures.
- Keep decisions, the contract between parts, code review and final verification in the main conversation, and review every subagent's changes before relying on them.
- Skip subagents for small changes, where writing the brief costs more than doing the work.

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
