#!/usr/bin/env bash
# Session rule 3: every research/*/REPORT.md must END with a verdict line:
#   **Verdict:** build | defer | closed — <reason>
# The last non-empty line must name exactly one verdict and give a reason.
# Prints offending files to stderr and exits 1 if any fail.
set -u
cd "$(dirname "$0")/.." || exit 2

re='^\*\*Verdict:\*\*[[:space:]]*\**(build|defer|closed)\**[[:space:]]*(—|–|-|:)[[:space:]]*[^[:space:]]'
fail=0; n=0
for f in research/*/REPORT.md; do
  [ -f "$f" ] || continue
  n=$((n + 1))
  last=$(grep -v '^[[:space:]]*$' "$f" | tail -n 1)
  if printf '%s\n' "$last" | grep -qiE "$re"; then
    echo "ok   $f"
  else
    echo "FAIL $f: last line is not '**Verdict:** build|defer|closed — <reason>'" >&2
    fail=1
  fi
done
echo "checked $n report(s)"
exit "$fail"
