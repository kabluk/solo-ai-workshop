# research

One folder per question: `YYYY-MM-slug/` with a `REPORT.md` inside.
Copy `_TEMPLATE.md` to start. Raw data (exports, SERP snapshots, JSON) goes
in the same folder, next to the report.

```
research/
  2026-01-example-idea/
    REPORT.md        conclusion, assessment, verdict
    serp-*.json      raw measurements (optional)
```

Every `REPORT.md` **ends** with one verdict line:

```
**Verdict:** build | defer | closed — <reason>
```

- **build** — name the repository to create. When it exists, append
  "Moved to `<owner>/<repo>`" to the same line and add a row to
  `PROJECTS.md`.
- **defer** — say what would have to change to reopen it.
- **closed** — say why, so nobody researches it again in six months.

`scripts/check-reports.sh` enforces this in CI. Folders are never deleted:
a closed idea is the cheapest research you will ever reuse.

`2026-01-example-idea/` is a fictional worked example — delete it once you
have a real report.
