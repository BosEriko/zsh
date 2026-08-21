---
name: task-explainer
description: Simplify complex software development tasks into plain language while preserving technical terminology and explaining jargon. Use when the user asks to understand, break down, explain, simplify, or summarize a development ticket, Jira issue, implementation task, or technical specification.
---

# Task Explainer

## Workflow

1. Read the entire task before explaining it.
2. Identify:
   - the current behavior
   - the problem
   - the desired behavior
   - the main components involved
   - explicit implementation requirements
   - explicit acceptance criteria
3. Rewrite the task in simpler language without removing technical terminology.
4. Whenever technical jargon appears, briefly explain what it means in context.
5. Identify the likely implementation flow in execution order.
6. Identify files explicitly mentioned by the task.
7. Infer additional files that are likely to be touched based on the requested changes.
8. Estimate the total number of files that will likely be:
   - created
   - modified
   - tested
9. Summarize the final expected behavior.
10. Reproduce the provided acceptance criteria in simpler language.
11. If acceptance criteria are missing or incomplete, add reasonable inferred acceptance criteria and clearly label them as inferred.
12. Call out dependencies, prerequisites, ambiguities, or anything that could block implementation.

## Output Format

Use the following structure.

### Simple Explanation

Explain the task as if speaking to a developer who understands programming but is unfamiliar with this part of the codebase.

Keep technical names such as:
- Step Functions
- Lambda
- DynamoDB
- SNS
- EventBridge
- IAM
- schemas
- handlers
- constructs

Do not replace them with vague alternatives.

Instead, explain them inline when useful.

Example:

> The task adds an AWS Step Functions state machine — an AWS workflow that runs multiple Lambda functions in a defined sequence.

### Current Behavior

Explain what happens today.

### Desired Behavior

Explain what should happen after the task is completed.

### Execution Flow

Show the expected runtime flow sequentially.

Example:

```text
DELETE /session
  ↓
cancelD2dSession
  ↓
Start Step Functions state machine
  ↓
Mark session cancelled
  ↓
Notify casino
  ↓
SNS
  ↓
deposit_cancelled webhook
