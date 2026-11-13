---
name: implement
description: Implement a development task end to end, covering task analysis, codebase exploration, planning, implementation, testing, code review, and final verification.
argument-hint: "What should be implemented?"
disable-model-invocation: true
---

# Development Workflow

If the user passed arguments, treat them as the task to implement.

Follow these steps in order. Do not skip a step unless it is clearly not applicable. Do not declare the task complete until Task Verification confirms that the implementation satisfies the requirements and acceptance criteria.

1. Task Analysis
2. Codebase Exploration
3. Task Planning
4. Implementation
5. Testing
6. Code Review
7. Task Verification

For small changes, keep each step brief and combine the outputs into one short summary instead of a separate section per step.

## Subagents

When building a feature, use subagents so the work goes faster and the main conversation stays small:

- Skip separate exploration subagents when the builders can explore their own area: give each builder the plan and the contract and let it read what it needs, so the same files aren't read twice. Use an explorer only when you need the map before you can settle the plan, for example to choose between approaches across several areas.
- Implement independent parts in parallel subagents once the plan is settled, as long as they don't edit the same files. Give each one a self-contained brief: the files involved, the agreed API shape between the parts, the repository conventions to follow, and what done looks like.
- Hand checks with long output (full test suites, lint, type checks, browser or simulator screenshots) to subagents that report back only the results and any failures.
- Keep decisions, the contract between parts, code review and final verification in the main conversation, and review every subagent's changes before relying on them.
- Skip subagents for small changes, where writing the brief costs more than doing the work.

## 1. Task Analysis

Turn the task into clear requirements, acceptance criteria, scope, and implementation-relevant information.

### Workflow

1. Read the complete task before inspecting implementation details.
2. Identify the problem being solved.
3. Identify the requested behavior or outcome.
4. Extract explicit requirements.
5. Extract existing acceptance criteria.
6. Infer reasonable acceptance criteria when they are missing.
7. Identify what is explicitly out of scope.
8. Identify technical terms, domain terminology, and dependencies that affect the task.
9. Identify ambiguities or missing information that could materially affect implementation.
10. Summarize the task in implementation-oriented language.

### Output

Provide:

- Summary
- Requirements
- Acceptance criteria
- Out of scope
- Important technical context
- Unknowns or assumptions

### Rules

- Preserve important domain and technical terminology.
- Explain unfamiliar terminology when it affects implementation.
- Do not invent product requirements.
- Distinguish explicit requirements from inferred requirements.
- Do not start implementation.
- Do not treat implementation details discovered later as original task requirements.
- Ask for clarification only when an ambiguity materially prevents safe implementation.

## 2. Codebase Exploration

Locate code relevant to the task, understand existing behavior, identify dependencies, and find established implementation patterns.

### Workflow

1. Start from identifiers, paths, endpoints, functions, events, models, or components mentioned in the task.
2. Locate the primary implementation.
3. Trace the relevant execution or data flow.
4. Identify callers and downstream dependencies when relevant.
5. Find tests covering the existing behavior.
6. Search for similar implementations elsewhere in the repository.
7. Identify repository conventions that should be followed.
8. Identify the files likely to require changes.
9. Note important constraints discovered during exploration.

### Output

Provide:

- Relevant execution flow
- Important files
- Existing patterns to reuse
- Relevant tests
- Likely files to change
- Dependencies or constraints

Include the estimated number of files that will need to change when reasonably determinable.

### Rules

- Explore before proposing new abstractions.
- Prefer established repository patterns.
- Do not assume a file must change simply because it was mentioned in the task.
- Do not modify files during exploration.
- Avoid exhaustive repository exploration when the relevant execution path is already clear.
- Distinguish confirmed findings from assumptions.

## 3. Task Planning

Create a concrete implementation plan based on the task requirements and repository exploration.

### Workflow

1. Review the task requirements and acceptance criteria.
2. Review findings from codebase exploration.
3. Determine the smallest implementation that satisfies the task.
4. Break the implementation into sequential steps.
5. Identify the files affected by each step.
6. Include required tests or test updates.
7. Account for error handling, edge cases, and compatibility when relevant.
8. Check that every acceptance criterion is covered by the plan.

### Output

Provide:

- Implementation approach
- Estimated files to change
- Sequential implementation steps
- Testing approach
- Risks or assumptions, if any

Keep implementation steps flat and actionable.

### Rules

- Do not implement code while planning.
- Avoid speculative changes.
- Prefer modifying existing abstractions over creating new ones when appropriate.
- Do not include unrelated refactoring.
- Every planned change must contribute to a requirement, acceptance criterion, test, or necessary supporting behavior.
- Call out blockers rather than silently designing around missing requirements.

## 4. Implementation

Implement the planned changes.

### Rules

- Follow the plan.
- If the plan needs to change, state the deviation and why instead of drifting from it silently.

## 5. Testing

Validate the changes by identifying, adding, and running the smallest relevant set of tests and checks.

### Workflow

1. Identify the behavior changed by the implementation.
2. Locate existing tests covering that behavior.
3. Determine whether existing tests are sufficient.
4. Add or update tests when required to validate new or changed behavior.
5. Run the most focused relevant tests first.
6. Fix failures caused by the implementation.
7. Run broader relevant tests when appropriate.
8. Run relevant type checking, linting, or build checks when appropriate.
9. Record what was run and the results.

### Rules

- Never claim a test or check passed unless it was actually run.
- Do not modify tests merely to make incorrect behavior pass.
- Test observable behavior rather than implementation details when possible.
- Follow existing testing conventions.
- Prefer focused tests before expensive broad test suites.
- Do not fix unrelated failing tests.
- Clearly distinguish failures caused by the current changes from pre-existing failures.
- Report checks that could not be run and why.

## 6. Code Review

Review the completed changes for correctness, regressions, unnecessary complexity, scope violations, and maintainability.

### Workflow

1. Review the complete diff.
2. Compare the changes with the implementation plan.
3. Check for correctness issues.
4. Check edge cases and error paths affected by the changes.
5. Check for regressions to existing behavior.
6. Look for unnecessary changes or scope creep.
7. Check whether existing repository patterns were followed.
8. Check for unnecessary abstractions, duplication, or complexity introduced by the change.
9. Check whether tests adequately cover the changed behavior.
10. Fix issues introduced by the implementation when appropriate.
11. Re-run affected tests after review fixes.

### Review Priorities

Prioritize:

1. Correctness
2. Data loss or destructive behavior
3. Security
4. Regressions
5. Missing requirements
6. Error handling
7. Maintainability
8. Style

### Rules

- Review the actual diff, not just the intended implementation.
- Focus primarily on issues introduced by the current changes.
- Do not turn review into unrelated refactoring.
- Do not change behavior merely because another approach is preferable.
- Report unresolved concerns clearly.
- If review changes the implementation, ensure affected validation is run again.

## 7. Task Verification

Verify that the completed implementation satisfies the original task, requirements, and acceptance criteria.

### Workflow

1. Re-read the original task.
2. Review the requirements identified during task analysis.
3. Review every explicit acceptance criterion.
4. Review any inferred acceptance criteria separately.
5. Inspect the final implementation and diff.
6. Review test and validation results.
7. Map each requirement and acceptance criterion to evidence in the implementation or tests.
8. Identify anything incomplete, partially implemented, or unverified.
9. Determine whether the task can be considered complete.

### Output

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

### Rules

- Verification is against the original task, not merely the implementation plan.
- Do not mark a requirement as passing solely because tests pass.
- Do not mark tests as passing unless they were actually run.
- Keep explicit and inferred acceptance criteria distinguishable.
- Do not hide incomplete work.
- Do not declare the task complete when a required criterion is FAIL or PARTIAL.
- Treat materially important UNVERIFIED criteria as incomplete unless there is sufficient evidence to justify completion.
