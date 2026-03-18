# Moovfinancial Image Bump

Use this skill when updating service image versions in platform-dev or infra repos after merging changes to a service.

## When to use

- After a service PR merges and CI builds a new image
- When updating docker-compose.yml in platform-dev to use a new dev image
- When bumping service versions in infra staging or production configs

## The pattern

### 1. Get the new commit SHA

After a PR merges (or for a dev branch), get the CI-built image tag:

```bash
# For a merged PR, get the latest commit on main/master
git -C /Users/benross/github.com/moovfinancial/<service> log --oneline -1 origin/main

# The image tag will be: dev-<short-sha> (for dev branches) or v<semver> (for releases)
```

### 2. Verify CI built the image

Check that CI has successfully built an image for that SHA before bumping. Don't bump to a SHA that hasn't been built yet — it will fail on deploy.

### 3. platform-dev (docker-compose.yml)

Located at: `/Users/benross/github.com/moovfinancial/platform-dev/docker-compose.yml`

Update the image tag for the relevant service:
```yaml
image: ghcr.io/moovfinancial/<service>:dev-<sha>
```

platform-dev PRs go to the `platform-dev` repo. Branch naming: `bump-<service>-<timestamp>`.

### 4. infra (staging + production)

The infra repo has separate config files for staging and production environments. Two separate PRs needed:
- `bump-staging-<service>-<timestamp>` branch → staging config
- `bump-production-<service>-<timestamp>` branch → production config

### 5. card-features config

`conf/card-features/config.yml` in platform-dev and infra controls sandbox PAN lists and BIN overrides. When adding new sandbox cards:
- Add PANs under the appropriate section (Visa/MC, completed/failed)
- Changes needed in all three: platform-dev, infra-staging, infra-production

## Parallel execution

When bumping multiple services or environments, use git worktrees to apply changes in parallel:

```bash
git worktree add /tmp/bump-staging origin/main
# edit in /tmp/bump-staging
# push from there
git worktree remove /tmp/bump-staging
```

## Notes

- Never bump production before staging has been validated
- bin-updater BIN metadata is compiled into the binary — no config change needed for BIN additions
- card-configuration uses Spanner; image bumps go through the same infra pattern
