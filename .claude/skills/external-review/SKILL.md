---
name: external-review
description: Use when the owner wants an outside opinion from other LLMs on a product or an idea, pastes back one or more such reviews, or asks what to do with them. Prepares a fact-loaded prompt, verifies every checkable claim against reality before acting, and keeps a per-model table so agreement and contradiction are visible.
---

# External review

Born on a live product: five models reviewed it, and of five checkable
claims four were false — while the single true one was worth more than all
the others together. The skill holds two disciplines: a prompt with real
numbers and explicit exclusions — and **an outside audit is a set of
hypotheses until each one is checked with your own tool**.

## Preparing the prompt — steps

1. **Collect FACTS from the live product (or the research folder), not from
   memory.** Every number is checked today: counters on the home page,
   traffic from the metrics log, the data cut-off date, revenue. A stale
   number is worse than a missing one: the model builds a conclusion on it
   and won't warn you.
2. **Open every URL in the "look at these pages" block.** One URL returning
   404 is enough for two models to conclude "the whole section is broken —
   delete it". Done when every URL answers 200.
3. **Write the exclusions explicitly** (what the product will never do) —
   otherwise half the answer goes to options already rejected.
4. **Fill in [`PROMPT.md`](PROMPT.md)** — placeholders in `{{…}}`. The shape
   of the prompt does not change: rank everything, name what to kill, an
   assumption and a one-week test for every recommendation, generic advice
   banned by name. Hand it to the owner whole, to paste without edits.

## A review came back — steps

1. **Split claims into checkable ones and judgements.** Checkable: about a
   specific page, number, link, behaviour. Judgement: about priority,
   monetisation, what to kill.
2. **Check every checkable claim with your own tool** (`curl` against
   production, a script over a sample, a data query). Done when each has a
   verdict: confirmed / exaggerated (with the measurement) / not confirmed.
   Typical false ones: "the page returns 500" (their crawler hit bot
   protection), "the list is all placeholders" (measured: 0 of 200),
   "there is no date" (there is).
3. **Confirmed → into the work immediately**; don't wait for other models
   to agree. A measured fact does not get truer from a second opinion.
4. **Judgements → a "who said what" table** per question: priority #1,
   first dollar, what to kill, contradictions. Agreement from ≥ 3 of 4 is a
   signal; a single mention is a hypothesis; **mutually exclusive claims are
   settled by a measurement, not by a third model**.
5. **What not to do even on unanimous advice:** anything irreversible
   (delete a layer, remove pages) without a single number on what it
   brings in. Unanimity on priority says nothing about being right in the
   details.
6. **Record it** — for an idea, in its research folder
   (`research/YYYY-MM-slug/review.md`); for a product, in that product's
   docs (`review-<month>.md`): attribution (which model), verdicts, the
   table, what was rejected and why. Actionable items go to the backlog;
   rejected advice goes to the decision log with its reason.

## Why this beats "just ask"

Without step 2 of the first part, the model spends its answer on the
prompt's mistake. Without step 2 of the second part, four false findings out
of five cost a day of work.
