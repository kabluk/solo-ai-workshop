#!/usr/bin/env bash
# SessionStart hook (playbook P-00). Its stdout is added to the session's
# context, so the ritual is injected rather than remembered (P-16).
# Prints: the ritual, the founder-profile state, whether idea-gates is
# installed, the research index with verdicts, and which credentials are
# present -- by NAME only, never a value.
set -u

root="${CLAUDE_PROJECT_DIR:-$(cd "$(dirname "$0")/../.." && pwd)}"
cd "$root" || exit 0

cat <<'TXT'
# Workshop session (research, ideas, experiments -- no product here)

Ritual: read CLAUDE.md and PROJECTS.md before acting. Every result lands in
research/YYYY-MM-slug/REPORT.md, committed as you go, ending with
"**Verdict:** build | defer | closed -- <reason>". Gates before the ocean:
check feasibility for this founder (docs/FOUNDER.md) before any market work.
End each committing cycle with the harvest skill and exactly three next-step
options (playbook P-08, P-09).
TXT

echo
echo "## Setup"
if [ -f docs/FOUNDER.md ] && grep -q '^- \*\*[^*]*:\*\* _' docs/FOUNDER.md; then
  echo "- docs/FOUNDER.md: still has blank fields -- ask the owner to fill it in before running any gates."
else
  echo "- docs/FOUNDER.md: filled in."
fi
if [ -f .claude/skills/idea-gates/SKILL.md ]; then
  echo "- idea-gates skill: installed."
else
  echo "- idea-gates skill: NOT installed. Install: git clone https://github.com/kabluk/idea-gates .claude/skills/idea-gates"
fi

echo
echo "## Research so far"
found=0
for f in research/*/REPORT.md; do
  [ -f "$f" ] || continue
  found=1
  d=$(dirname "$f")
  v=$(grep -oiE '\*\*Verdict:\*\*[[:space:]]*\**(build|defer|closed)' "$f" | tail -1 | grep -oiE '(build|defer|closed)$' || true)
  echo "- ${d#research/} -- ${v:-NO VERDICT}"
done
[ "$found" -eq 1 ] || echo "- nothing yet"

# Credential inventory. Edit this list to match the services you use.
present=(); missing=()
for name in GITHUB_TOKEN DATAFORSEO_LOGIN DATAFORSEO_PASSWORD FIRECRAWL_API_KEY APIFY_TOKEN; do
  if [ -n "${!name:-}" ]; then present+=("$name"); else missing+=("$name"); fi
done
echo
echo "## Credentials (by name; presence is not capability -- probe before relying, P-01b)"
echo "- present: ${present[*]:-none}"
echo "- missing: ${missing[*]:-none}"
echo "- Never ask for a value in chat; say which variable or CI secret it belongs in."
exit 0
