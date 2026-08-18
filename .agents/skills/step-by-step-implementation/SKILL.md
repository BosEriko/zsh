---
name: step-by-step-implementation
description: Implement an approved development plan one step at a time with explicit user confirmation before changes. Use when executing a planned code change or working through an implementation plan.
---

# Step-by-Step Implementation

## Workflow

1. Select the current implementation step.
2. Explain exactly what will be changed.
3. Identify the files that will be modified, created, or deleted.
4. Explain the purpose of the changes.
5. Ask the user for confirmation.
6. After confirmation, implement only the current step.
7. Show what changed and briefly explain the result.
8. Ask whether the user wants to commit the changes.
9. Handle the commit decision before proceeding to the next step.
10. Repeat the workflow for the next implementation step.

## Rules

- Never modify files without explicit user confirmation.
- Work on exactly one implementation step at a time.
- Never implement multiple planned steps unless explicitly requested.
- Do not start the next step before the current step is complete.
- Do not make unrelated changes.
- Always explain changes before modifying files.
- Always identify affected files before modifying them.
- After each completed step, ask whether the user wants to commit.
- If requirements change, update the implementation plan before continuing.
- If a step becomes unnecessary, explain why and ask whether to skip it.
- If a new required step is discovered, explain it and add it to the plan before proceeding.
