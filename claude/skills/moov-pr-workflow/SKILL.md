# Moovfinancial PR Workflow

Use this skill when completing a feature or fix across one or more moovfinancial repos.

## Steps

1. **Read the PR template** for the repo: `.github/PULL_REQUEST_TEMPLATE.md` — keep it open, you will fill it out exactly at step 8
2. **Run nullscan** on any repo with DB code: `go run github.com/moovfinancial/nullscan@latest ./...` — fix all violations before proceeding
3. **Run targeted tests** for affected packages: `go test ./pkg/affected/... -run TestName -v`
4. **Run full CI**: `make check` — must pass before committing
5. **Run `/review`** — invoke the review skill against the current diff before committing; fix any issues it surfaces
6. **Commit** with a descriptive message referencing the Linear ticket (e.g. CAR-XXXX)
7. **Push**: `git push`
8. **Create PR as draft** for multi-repo features; open for review only when all repos in the dependency chain have PRs
9. **Fill out the PR description** using the template read in step 1 — every section of the template must be present and filled in; do not omit or reorder sections
10. **Repo context switching**: run `make teardown` in current repo, then `make setup` in next

## Multi-repo features
When a feature spans multiple repos, follow the dependency order:
cards/events → card-configuration → card-gateway → visa-gateway → paymentmethods

Create a PR in each repo. Read each repo's `.github/PULL_REQUEST_TEMPLATE.md` independently — templates differ between repos. Every section must be present and filled in.

## platform-dev is different
`platform-dev` is an **integration test repo**, not a production service. Key differences:
- No unit tests — all tests are integration tests that run against live local services (docker-compose stack must be running via `make setup`)
- **Do not run `go test` in platform-dev without a running stack** — tests will fail with connection errors, not test logic errors
- No `make check` in the traditional sense — CI runs tests against a live environment
- PRs here change test scenarios, scope constructors, or seed data — not production service logic
- Changes to `pkg/seed/` affect all tests; changes to `pkg/test/` affect multiple scope types; changes to `pkg/cards/` are usually scoped to card-specific tests
