---
description: Custom instructions for Petty_VMCS_SaaS project
applyTo: "**/*.{php,vue,js,ts,json,md}"
---
# Custom Instructions

## 1. Project Architecture
* **Backend**: Laravel 12 (PHP 8.2), Sanctum, DomPDF, Migrations.
* **Frontend**: Vue 3 (Composition API), Vite, Tailwind CSS 3.4+, Axios.

## 2. Coding Patterns
* **Backend**: PSR-12, Form Request Validation, logic into Services/Repositories, DB::transaction().
* **Frontend**: Composition API only, Vue Components for reusability, safe error handling with Axios. MUST use `frontend-design` and `ui-ux-pro-max` skills for any UI/UX or layout tasks.

## 3. Global Rules
* **Direct Edits**: Do not print code blocks, write directly to files.
* **Language**: Comments in English, docs/logs in Vietnamese.
* **No Destructive DB**: Ask before running db resets or migrations.
* **API Sync**: Update Frontend Axios when Backend API response changes.

## OpenSpec Protocol — READ THIS BEFORE ANY TASK

### 1. Before starting any work on a change

Check `openspec/changes/<name>/HANDOFF.md`:
- If it exists → read it fully before writing a single line of code
- If it does not exist → proceed, HANDOFF.md was created by `/opsx:propose`

Do NOT skip this step. Do NOT assume you know the current state from conversation history alone.

### 2. After git pull or starting a new session

Run these two checks before asking the user what to do:
```bash
git log --oneline -20
```
Then read `openspec/PROJECT_STATE.md`.

Report back:
- What the team has done recently (from git log)
- What the system state is (from PROJECT_STATE.md)
- Which changes are IN_PROGRESS and should not be touched

### 3. Context health — monitor continuously

Track these signals throughout the session:

| Signal | Warn threshold | Stop threshold |
|---|---|---|
| Tool calls this session | 20 | 35 |
| Large files read (>100 lines) | 5 | 8 |
| Conversation turns | 15 | 25 |
| File edits within a single task | 4 | 7 |

**At Warn threshold:** Stop before the next task and say:
> "⚠️ Context is getting long. Recommend saving progress now.
> Run `/opsx:handoff` or type 'save and stop'."
Wait for user response.

**At Stop threshold:** Do not start the next task. Say:
> "⛔ Context limit reached. Stopping now to protect progress.
> Saving HANDOFF.md before ending session."
Then perform Emergency HANDOFF (see section 4).

### 4. Emergency HANDOFF procedure

Use this when the session must end immediately — quota warning, context overflow,
or user says: "stop", "quota", "limit", "switch", "that's enough", "pause".

Do this immediately, before any other response:

Step 1 — Write to HANDOFF.md right now with whatever is known:
```
# HANDOFF — <name>
**Status:** IN_PROGRESS
**Last updated:** <timestamp>
**Tool used:** Claude Code
**Emergency stop:** YES — <reason>

## Task Progress
<copy current state of tasks.md — mark what is confirmed done>

## Stopped At
**File:** <last file touched>
**Location:** <last function or section>
**State:** <what is complete vs what is half-done>

## IMPORTANT — Incomplete work
<describe exactly what was being written when stopped>
<note any files that may be in a broken/partial state>

## Next Steps
1. Check <file> for incomplete implementation
2. <next task>

## How to Resume
1. Read this file
2. Check <file> for partial work — complete or revert it first
3. Then continue with Next Steps above
```

Step 2 — Tell the user:
> "Emergency HANDOFF saved. Safe to close or switch tools.
> Resume with: 'Read openspec/changes/<name>/HANDOFF.md and continue.'"

### 5. Mid-task checkpoint

If a single task requires editing more than 4 files:
- After every 4th file edit, write an intermediate HANDOFF.md update
- Mark the task as IN_PROGRESS (not complete) with note: "Partial — completed X of Y files"
- Continue the task
- Update again when task fully completes

This ensures that even a crash mid-task loses at most 4 file edits, not the whole task.

### 6. Updating PROJECT_STATE.md

Update `openspec/PROJECT_STATE.md` when:
- A change is archived (`/opsx:archive`)
- A major feature reaches READY_FOR_REVIEW
- A significant architectural decision is made

Do NOT update it after every task — only at meaningful milestones.