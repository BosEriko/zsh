---
name: codebase-exploration
description: Explore the repository to locate code relevant to a development task, understand existing behavior, identify dependencies, and find established implementation patterns. Use after understanding the task and before planning changes.
---

# Codebase Exploration

## Workflow

1. Start from identifiers, paths, endpoints, functions, events, models, or components mentioned in the task.
2. Locate the primary implementation.
3. Trace the relevant execution or data flow.
4. Identify callers and downstream dependencies when relevant.
5. Find tests covering the existing behavior.
6. Search for similar implementations elsewhere in the repository.
7. Identify repository conventions that should be followed.
8. Identify the files likely to require changes.
9. Note important constraints discovered during exploration.

## Output

Provide:

- Relevant execution flow
- Important files
- Existing patterns to reuse
- Relevant tests
- Likely files to change
- Dependencies or constraints

Include the estimated number of files that will need to change when reasonably determinable.

## Rules

- Explore before proposing new abstractions.
- Prefer established repository patterns.
- Do not assume a file must change simply because it was mentioned in the task.
- Do not modify files during exploration.
- Avoid exhaustive repository exploration when the relevant execution path is already clear.
- Distinguish confirmed findings from assumptions.
