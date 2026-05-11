#!/usr/bin/env bash
# PreToolUse:Edit|Write|MultiEdit — nudges the agent to consult relevant skills
# based on file-path globs in ~/.claude/hooks/skill-map. The map is generated
# by build-skill-map.sh, which uses the `claude` CLI to infer triggers from
# each skill's SKILL.md. If the map doesn't exist, this hook is a silent no-op.
#
# Pairs with record-skill-read.sh, which tracks consulted skills so this hook
# only nudges for skills not yet read.
#
# Exit codes: 0 = allow (with optional advisory on stderr)

INPUT=$(cat)

TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // empty')
case "$TOOL_NAME" in
  Edit|Write|MultiEdit) ;;
  *) exit 0 ;;
esac

FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')
[ -z "$FILE" ] && exit 0

MAP="${HOME}/.claude/hooks/skill-map"
[ -f "$MAP" ] || exit 0

STATE_DIR="${HOME}/.claude/cache/agent-state"
SKILLS_READ="${STATE_DIR}/skills-read.txt"
SKILLS_DIR="${HOME}/.claude/skills"
mkdir -p "$STATE_DIR"
touch "$SKILLS_READ"

while IFS=$'\t' read -r glob skill; do
  [ -z "${glob:-}" ] && continue
  [ -z "${skill:-}" ] && continue
  case "$glob" in '#'*) continue ;; esac
  # shellcheck disable=SC2053
  if [[ $FILE == $glob ]]; then
    grep -qxF "$skill" "$SKILLS_READ" && continue
    echo "REMINDER: editing $FILE — consider reading skill '$skill' (cat $SKILLS_DIR/$skill/SKILL.md) if you haven't already." >&2
  fi
done < "$MAP"

exit 0
