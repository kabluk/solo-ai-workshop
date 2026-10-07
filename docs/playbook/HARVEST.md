# HARVEST — ledger of extracted methods

Cross-project memory. Every repeat that became a skill, a playbook rule or a
gotcha is recorded here: date, project, what repeated, where it landed. The
ledger travels with the playbook into every repository; the canonical copy
lives next to the canonical playbook. Filled in by the `harvest` skill (P-09).

Line format: `date | project | repeat (how many times) → home`.

## YYYY-MM

<!-- Example (fictional):
- 03.01 | parcelping | a bare `X=$(cmd)` under `bash -e` killed a CI step
  silently (3 times) → playbook P-01b; gotcha in parcelping/CLAUDE.md.
- 05.01 | workshop | market sized before the first step was checked
  (2 ideas) → session rule 6 "gates before the ocean".
-->

## 2026-10

- 10.07 | workshop | non-business research (used-car search) run in the workshop
  (1 cycle) → no repeat ≥ 2, nothing extracted.

## Open candidates

Repeats seen once more than noise but not yet given a home. One line each,
with the count and what would settle the home.

- Apify `apify/facebook-marketplace-scraper`: city slug `losangeles` silently
  returns national results, `la` works; filter by lat/lon after the run
  (seen 1×, 2026-10). Becomes a skill or CLAUDE.md gotcha on the second
  Marketplace search.
