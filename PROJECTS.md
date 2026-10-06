# Project registry

Updated: YYYY-MM-DD (checked against the repositories themselves, not memory).

One line per product. Edit this file **in the same session** that creates,
renames, moves or archives a repository — a week-old registry already lies.

> The two rows below are **fictional examples**. Replace them with your own.

## Products

| Project | Repository | Stage | Live at | Next step |
|---|---|---|---|---|
| **Example: ParcelPing** | `your-name/parcelping` | LIVE: 120 shops on free tier, daily cron healthy | parcelping.example | first paid plan: pricing page + checkout |
| **Example: QuietInvoice** | `your-name/quietinvoice` | spec only, no code | — | phase 0: confirm the accounting API allows read access for third-party apps |

Stage vocabulary: *idea* (lives in `research/`) → *spec* → *building* →
*LIVE* → *frozen* (deliberately, with a reason) → *archived*.

## Workshop and tooling

| What | Repository | State |
|---|---|---|
| Workshop: research, ideas, experiments, this registry | `your-name/workshop` (this repo) | live — every research session starts here |
| Feasibility gates skill | [`kabluk/idea-gates`](https://github.com/kabluk/idea-gates) | installed into `.claude/skills/idea-gates/` |

## Loose ends

<!-- Orphan branches, stray PRs, repos to archive. Strike through when done:
     - ~~`your-name/old-thing`~~ — ARCHIVED YYYY-MM-DD (reason). -->

## Rules

1. **New project = its own repository named after the product.** Not a
   branch, not a folder in someone else's repo (`docs/REPO-POLICY.md`).
2. **Start each session from the project's own repository.** A pile of
   orphan branches in an archive is the price of starting "from wherever".
3. **This registry is edited in the same session** that moves or renames a
   repository.
4. **Research, ideas, experiments — session from the workshop.** One
   question = one folder `research/YYYY-MM-slug/` with a `REPORT.md` ending
   in a verdict. A matured idea → its own repository + a line here; the
   research folder keeps a "Moved to X" pointer.
