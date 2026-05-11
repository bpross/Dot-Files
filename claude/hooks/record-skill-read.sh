#!/bin/sh
# PostToolUse:Read — records which skills the agent has read this session.
# When the agent reads ~/.claude/skills/<name>/SKILL.md (or any resolved path
# ending in /skills/<name>/SKILL.md), the skill name is appended to
# ~/.claude/cache/agent-state/skills-read.txt so remind-skill.sh won't nag again.
#
# Exit codes: 0 = always allow

INPUT=$(cat)

TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // empty')
[ "$TOOL_NAME" = "Read" ] || exit 0

FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')
[ -z "$FILE" ] && exit 0

case "$FILE" in
  */skills/*/SKILL.md) ;;
  *) exit 0 ;;
esac

# Extract skill name: the segment immediately before /SKILL.md
SKILL=$(echo "$FILE" | sed -E 's|.*/skills/([^/]+)/SKILL\.md$|\1|')
[ -z "$SKILL" ] && exit 0
[ "$SKILL" = "$FILE" ] && exit 0

STATE_DIR="${HOME}/.claude/cache/agent-state"
mkdir -p "$STATE_DIR"
SKILLS_READ="${STATE_DIR}/skills-read.txt"
grep -qxF "$SKILL" "$SKILLS_READ" 2>/dev/null || echo "$SKILL" >> "$SKILLS_READ"

exit 0
