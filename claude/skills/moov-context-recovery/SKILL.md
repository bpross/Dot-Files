# Moovfinancial Context Recovery

Use this skill whenever a session begins with a context-compression summary (i.e. "This session is being continued from a previous conversation that ran out of context").

## The problem

When context is compressed, the summary may be stale or incomplete — branches may have diverged, stashes may exist, uncommitted work may be on the wrong branch. Acting on summary state without verifying actual git state causes silent mistakes that the user has to catch and interrupt.

## Required steps before taking ANY action

1. **Read the summary** — understand what was in progress
2. **Check actual git state in all relevant repos** — do NOT assume the summary is current:
   ```bash
   git status
   git log --oneline -5
   git stash list
   git branch
   ```
3. **Narrate what you found** — state in plain English:
   - What branch each repo is on
   - Whether there are uncommitted changes or stashes
   - What you believe the next action should be
   - Any discrepancy between the summary and actual state
4. **Wait for confirmation if state is ambiguous** — if there's a stash, uncommitted changes on an unexpected branch, or conflicting state, describe it and ask before touching anything

## Anti-patterns to avoid

- Starting a `git stash pop`, `git checkout`, or `git rebase` without first narrating intent
- Assuming the summary's branch names / commit SHAs are still current
- Silently resolving merge conflicts without stating what the conflict is

## Example narration (good)

> "We're on `master` in card-gateway with 3 unstaged changes. There's also a stash (`stash@{0}: WIP on feature/car-4651`). The summary says these changes belong on `feature/car-4651`. I'll stash pop onto that branch. Proceeding."

## Trigger phrases

- "This session is being continued from a previous conversation"
- "The summary below covers the earlier portion"
- Any session that opens with a multi-paragraph summary block
