# Moovfinancial Nullscan

Use this skill when running nullscan against moovfinancial services, or when fixing nullscan violations.

Nullscan is an internal tool that detects nullable DB columns scanned into bare Go types (string, int64, bool, time.Time, etc.) that should use sql.Null* or *T equivalents.

## When to run

- Before opening any PR on a repo that has DB code (any repo with migrations)
- When asked to "run nullscan" on a service or set of services
- After adding new DB scan code (repo_*.go files)

## Invocation

```bash
# Run against a single repo
go run github.com/moovfinancial/nullscan@latest ./...

# Run from a specific directory
cd /Users/benross/github.com/moovfinancial/<repo>
go run github.com/moovfinancial/nullscan@latest ./...
```

## How it works

Nullscan parses migration SQL files to find nullable columns (columns without `NOT NULL`), then uses Go AST analysis to find scan sites in `*.go` files where those columns are read into bare non-nullable types.

It matches by column name convention: the Go variable name must match the SQL column name (same file scoping rule).

## Types it checks

- `string` → use `sql.NullString`
- `int`, `int32`, `int64`, `uint`, `uint32`, `uint64` → use `sql.NullInt64` / `sql.NullInt32`
- `float32`, `float64` → use `sql.NullFloat64`
- `bool` → use `sql.NullBool`
- `time.Time` → use `sql.NullTime`

Pointer types (`*string`, `*int64`, etc.) are safe — nullscan ignores them.

## Fixing violations

1. Change the scan variable type to the appropriate `sql.Null*` type
2. After scanning, extract the value: `if v.Valid { use(v.String) }`
3. Or propagate as pointer: `var out *string; if v.Valid { out = &v.String }`

## Output format

```
repo/path/to/file.go:42: nullable column "column_name" scanned into bare string
```

Each line = one violation. Fix all before proceeding to PR.

## Repos that need nullscan

Any repo with a `migrations/` or `db/migrations/` directory. Currently includes:
card-gateway, paymentmethods, card-orchestrator, card-account-updater, card-transactions, card-issuing, amex-settlement, disco-settlement, visa-settlement-parser
