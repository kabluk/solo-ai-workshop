#!/usr/bin/env bash
# Stop hook (playbook P-08/P-09): a work cycle may not end without harvest
# and three next-step options, nor with a research report missing its verdict.
#
# A WORK CYCLE = since the owner's last text message, the agent ran
# `git commit`, `git push` or merged a PR. Answering a question without
# changes is not a cycle, and the hook stays silent.
#
# Loop guard: when stop_hook_active is set we exit at once -- the hook blocks
# exactly once, after that the model decides.
set -u
root="${CLAUDE_PROJECT_DIR:-$(cd "$(dirname "$0")/../.." && pwd)}"
IN=$(cat)
command -v python3 >/dev/null 2>&1 || exit 0

reports_msg=""
if [ -x "$root/scripts/check-reports.sh" ] || [ -f "$root/scripts/check-reports.sh" ]; then
  reports_msg=$(cd "$root" && bash scripts/check-reports.sh 2>&1 >/dev/null) || true
fi

python3 - "$IN" "$reports_msg" <<'PY'
import json, sys
try:
    ev = json.loads(sys.argv[1])
except Exception:
    sys.exit(0)                      # unreadable input: don't interfere
if ev.get("stop_hook_active"):
    sys.exit(0)                      # second pass: never loop
reports_msg = sys.argv[2].strip()
path = ev.get("transcript_path") or ""
try:
    lines = open(path, encoding="utf-8").read().splitlines()
except Exception:
    sys.exit(0)                      # no transcript: don't interfere

# Index of the owner's last TEXT message: the cycle starts there.
start = 0
for i, l in enumerate(lines):
    try:
        r = json.loads(l)
    except Exception:
        continue
    m = r.get("message") or {}
    if r.get("type") == "user" and isinstance(m.get("content"), str):
        start = i

worked = asked = harvested = False
WORK = ("git commit", "git push")
for l in lines[start:]:
    try:
        r = json.loads(l)
    except Exception:
        continue
    c = (r.get("message") or {}).get("content")
    if not isinstance(c, list):
        continue
    for b in c:
        if not (isinstance(b, dict) and b.get("type") == "tool_use"):
            continue
        name = b.get("name") or ""
        inp = b.get("input") or {}
        if name == "AskUserQuestion":
            asked = True
        if name == "Skill" and inp.get("skill") == "harvest":
            harvested = True
        if name.endswith("merge_pull_request"):
            worked = True
        if name == "Bash" and any(w in (inp.get("command") or "") for w in WORK):
            worked = True

if not worked:
    sys.exit(0)
need = []
if reports_msg:
    need.append("every research/*/REPORT.md must end with a verdict line ("
                + reports_msg.replace("\n", "; ") + ")")
if not asked:
    if not harvested:
        need.append("the harvest skill (P-09): what repeated, where it landed, "
                    "an entry in docs/playbook/HARVEST.md")
    need.append("exactly three next-step options via AskUserQuestion (P-08)")
if need:
    print(json.dumps({
        "decision": "block",
        "reason": "The work cycle ended (commits were made) but this is not done: "
                  + "; ".join(need) + ". Do it now, then finish."
    }))
PY
exit 0
