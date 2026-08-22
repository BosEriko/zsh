---
name: task-analysis
description: Analyze a development task and turn it into clear requirements, acceptance criteria, scope, and implementation-relevant information. Use before planning or implementing a development task.
---

# Task Analysis

## Workflow

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

## Output

Provide:

- Summary
- Requirements
- Acceptance criteria
- Out of scope
- Important technical context
- Unknowns or assumptions

## Rules

- Preserve important domain and technical terminology.
- Explain unfamiliar terminology when it affects implementation.
- Do not invent product requirements.
- Distinguish explicit requirements from inferred requirements.
- Do not start implementation.
- Do not treat implementation details discovered later as original task requirements.
- Ask for clarification only when an ambiguity materially prevents safe implementation.
