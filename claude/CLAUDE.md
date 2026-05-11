## Tooling for shell interactions
Is it about finding FILES? use 'fd' 
Is it about finding TEXT/strings? use 'rg' 
Is it about finding CODE STRUCTURE? use 'ast-grep'
Is it about SELECTING from multiple results? pipe to 'fzf' 
Is it about interacting with JSON? use 'jq' 
Is it about interacting with YAML or XML? use 'yq'

@RTK.md

## Payment Gateway Patterns

File locations (moovfinancial repos):
- TypeSpec models: `specification/{gateway}/models.{entity}.tsp`
- Settlement token: `specification/settlement/models.token.tsp`
- Gateways: `amex`, `visa`, `disco`, `mc`

When adding a field across all gateways: update each `specification/{gateway}/models.*.tsp`, update `specification/settlement/models.token.tsp` if the field flows through settlement, then run `make check`.

## Moov Documentation

Always verify API semantics before assuming field names or types:
1. Check `specification/*.tsp` in-repo first
2. Use `mcp__moov-docs__*` tools for hosted API docs
Never guess API shape — always verify in spec.
