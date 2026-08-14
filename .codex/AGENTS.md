# Codex Workflow

## Task Intake

When Codex is opened, wait for the user to provide the task description.

Do not ask the user "What's your task for today?" or any other introductory question. The user will directly send the task description.

The user's first message should be treated as the task to work on.

---

## Task Analysis

After receiving the task:

1. Analyze the task thoroughly.
2. Determine the required changes.
3. Create a list of sequential implementation steps.

The implementation plan must contain only one level of steps.

Use this format:

1. Step one
2. Step two
3. Step three

Do not create nested steps or substeps such as:

* A1
* A2
* B1
* B2
* 1.1
* 1.2

Keep every step at the same level.

After presenting the implementation plan, ask:

"Do you want to divide this task into smaller parts, or proceed with the plan as-is?"

---

## Dividing the Task

If the user chooses to divide the task into smaller parts:

1. Break the original task into smaller, logical tasks.
2. Present the smaller tasks as a simple, single-level numbered list.
3. Do not use nested numbering or substeps.
4. Ask the user which task they want to work on first.

Once the user selects a task, treat it as the current task and follow the workflow below.

---

## Step-by-Step Implementation

Work through the implementation plan one step at a time.

Never implement multiple planned steps at once unless the user explicitly asks you to.

Before implementing the current step:

1. Explain exactly what you are going to change.
2. Identify the files that will be modified, created, or deleted.
3. Explain the purpose of the changes.
4. Ask the user for confirmation.

Do not make any code or file changes before the user confirms.

---

## Applying the Change

After the user confirms:

1. Implement only the current step.
2. Do not start the next step.
3. Do not make unrelated changes.
4. Show the user what was changed.
5. Briefly explain the result.

After completing the current step, ask:

"Do you want to commit these changes?"

---

## Git Commit

If the user wants to commit:

1. Create a Git commit using the Gitmoji convention.
2. Choose the Gitmoji that best represents the change.
3. Use a concise commit message.
4. Show the commit that was created.

Example:

```text
✨ Add user authentication flow
🐛 Fix subscription status validation
♻️ Refactor payment service
📝 Update API documentation
🧪 Add tests for deposit orders
```

Do not commit changes unless the user explicitly confirms that they want to commit.

---

## Proceeding to the Next Step

After the current step has been completed and the commit decision has been handled:

1. Move to the next implementation step.
2. Explain exactly what you are going to change.
3. Identify the files that will be modified, created, or deleted.
4. Ask the user for confirmation.
5. Wait for confirmation before making changes.

Repeat this process for every implementation step.

Only work on one implementation step at a time.

---

## Completing the Task

Continue working through the implementation plan until all steps are completed.

After the final step:

1. Confirm that all planned steps have been completed.
2. Provide a concise summary of the overall changes.
3. Mention any remaining issues, limitations, or follow-up work if applicable.

Do not automatically make additional changes beyond the agreed implementation plan.

---

## Important Rules

* Never modify files without explicit user confirmation.
* Never implement multiple planned steps at once.
* Always work on exactly one step at a time.
* Always explain what will be changed before making changes.
* Always ask for confirmation before making changes.
* After each completed step, ask whether the user wants to commit.
* Git commits must follow the Gitmoji convention.
* Never use nested implementation steps such as A1, A2, B1, B2, 1.1, or 1.2.
* Keep implementation plans simple, sequential, and single-level.
* Do not make unrelated changes.
* If the user changes the requirements, update the implementation plan before continuing.
* If a step becomes unnecessary, explain why and ask whether to skip it.
* If a new required step is discovered, explain it and add it to the implementation plan before proceeding.
