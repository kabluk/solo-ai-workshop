# Workshop — the solo builder's operating system

This repository is the **workshop**: research, ideas and experiments that
belong to no product yet, plus the registry of every product
(`PROJECTS.md`). **There is no product here** — do not look for a
production site, a deploy or product code.

Start every idea, niche hunt, "is X worth it?" and prototype session from
this repository. Products live in their own repositories.

## Session rules

1. **Results land in a file.** Research that leaves no
   `research/YYYY-MM-slug/REPORT.md` didn't happen: the chat will close and
   the work will be lost. Commit as you go, not at the end.
2. **One question, one folder.** Nothing in the repository root, no branch
   per thought (that is how archives fill up with orphan branches).
3. **A verdict is mandatory.** `REPORT.md` ends with a single verdict line:
   `**Verdict:** build | defer | closed — <reason>`. "Interesting, unclear"
   is not a verdict. CI rejects a report without one
   (`scripts/check-reports.sh`).
4. **Numbers carry a source.** Demand, CPC, market size: a link next to the
   number, or a raw-data file in the same folder. Without a source, label it
   *estimate* — never present a guess as a measurement.
5. **A matured idea gets its own repo.** Do not build the product here.
   Creating the repository is the owner's button; add its line to
   `PROJECTS.md` in the same session, and append "Moved to `<owner>/<repo>`"
   to the research report's verdict line.
6. **Gates before the ocean.** Every idea goes through the six feasibility
   gates for *this* founder (`docs/FOUNDER.md`) first: first step, trust,
   small-customer arithmetic, measurability, channel, regulatory risk. Only
   survivors get market analysis. Analysis of an idea whose first step the
   founder cannot take is thrown-away work.

## Operating instructions

**Session start.** The `SessionStart` hook prints the ritual, the research
index with verdicts, and which credentials are present (by name). Read
`PROJECTS.md` before touching anything that might already exist.

**"Check idea X".** Read `docs/FOUNDER.md` first. If it is still the blank
template, stop and ask the owner to fill in at least *Basics*, *Hard
constraints* and *Resources* — gates computed against an imaginary founder
are worthless. Then run the `idea-gates` skill. If
`.claude/skills/idea-gates/` is missing, give the owner the install command
as the first line:
`git clone https://github.com/kabluk/idea-gates .claude/skills/idea-gates`
and meanwhile walk the six gates from rule 6 by hand in the report.

**Research folder.** Create `research/YYYY-MM-slug/` from
`research/_TEMPLATE.md`. Raw data (exports, SERP snapshots, JSON) sits next
to `REPORT.md`. Never delete a closed folder: it is the history of the
decision and stops the same idea being researched twice.

**Forks.** At a strategic fork, give three options with trade-offs and a
recommendation; the owner chooses. Step-by-step instructions for the owner
start with a direct link on the first line (the owner is often on a phone).

**End of a work cycle.** A cycle is any stretch that produced a commit. Run
the `harvest` skill, then offer exactly three next steps, recommended one
first (playbook P-08, P-09). The `Stop` hook blocks once if a committing
cycle ends without either, or with a report missing its verdict.

**Credentials.** Never ask for a secret value in chat. If a task needs a
missing key, say once which variable or CI secret it belongs in.

## Where things live

| What | Where |
|---|---|
| Product registry | `PROJECTS.md` |
| Founder profile (gates are computed from it) | `docs/FOUNDER.md` |
| Repository rules | `docs/REPO-POLICY.md` |
| Cross-project working agreements (P-NN) | `docs/playbook/COLLABORATION.md` |
| Harvest ledger | `docs/playbook/HARVEST.md` |
| Research | `research/YYYY-MM-slug/REPORT.md` |
| Skills: `harvest`, `external-review`, `writing-for-agents` | `.claude/skills/` |
| Feasibility gates (installed separately) | `.claude/skills/idea-gates/` |
| Hooks | `.claude/hooks/`, wired in `.claude/settings.json` |

Edit any skill, `CLAUDE.md` or playbook rule through `writing-for-agents`.

## Gotchas

<!-- Facts true only of this repository, added by `harvest`:
     symptom → fix, one bullet each. -->
