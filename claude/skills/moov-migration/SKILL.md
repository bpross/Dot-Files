# Moovfinancial Database Migration Skill

Use this skill when adding database migrations to any moovfinancial repo.

## Rules by repo

### card-gateway
- Postgres only
- Sequential numbering: `NNN_description.up.sql`
- No `IF NOT EXISTS` — migrations run once against a fresh schema in CI

### card-configuration
- Spanner — different tooling, check existing migrations before adding

### paymentmethods
- Directory contains TWO sets of files — **only use `.up.postgres.sql` files**
- The `.up.sql` files are legacy MySQL — **ignore them entirely**
- Sequential numbering: `NNN_description.up.postgres.sql`
- No `IF NOT EXISTS`
- `000_noop.up.postgres.sql` = full schema for new DBs; do NOT modify it for new columns
- New columns = new incremental file only

### card-orchestrator
- Postgres only
- Sequential numbering: `NNN_description.up.sql`
- No `IF NOT EXISTS`

### card-account-updater
- Postgres only
- Sequential numbering: `NNN_description.up.sql`
- No `IF NOT EXISTS`

### card-transactions
- Postgres only
- Sequential numbering: `NNN_description.up.sql`
- No `IF NOT EXISTS`

### card-issuing
- Postgres only
- Sequential numbering: `NNN_description.up.sql`
- No `IF NOT EXISTS`

### visa-gateway
- No DB — skip this skill

### mc-gateway
- No DB — skip this skill

## Checklist before writing a migration
1. Check the highest existing migration number in the directory
2. Use next sequential number
3. No `IF NOT EXISTS`
4. Do not modify `000_noop` files
5. Run `make check` to verify migrations apply cleanly
