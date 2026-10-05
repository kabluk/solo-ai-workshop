---
name: harvest
description: Use at the end of every work cycle and before any handoff, whenever the same steps or the same explanation happen a second time, whenever the owner says "again" / "every time", and whenever a lesson is written into a decision log. Turns repeats into skills, playbook rules, or CLAUDE.md gotchas, and records the harvest in a cross-project ledger so the next project does not start from zero.
---

# Harvest

Projects kept starting from a blank page. Lessons were written into one
project's decision log and died there; the next project never saw them, and
the agent never once offered to turn a repeat into a skill. Harvest is the
duty to turn a repeat into a method.

A **repeat** is any of: the same steps done a second time (in this session,
or known from a previous handoff or decision log); the same explanation to
the owner a second time; the same request to the owner a second time; a
decision-log entry containing the word "lesson"; the owner saying "again",
"every time", "once more".

## Steps

1. **Collect candidates.** Re-read your session from the start — from facts
   (commits, decisions logged this session, the owner's questions), not from
   memory. Write each repeat as one line: what repeated, how many times,
   where. Done when the list is empty or every item has a count ≥ 2.
2. **Give each one a home.** Three homes, by the nature of the candidate:
   - **skill** — a procedure with steps, needed in other projects
     (`.claude/skills/<name>/`, written per `writing-for-agents`);
   - **playbook rule** — an agreement on how we work
     (`docs/playbook/COLLABORATION.md`, a new P-NN);
   - **project gotcha** — a fact about this repository only
     (`CLAUDE.md` or the handoff note, section "Gotchas").
   A candidate with no home is noise, not a repeat: strike it.
3. **Write it.** A skill gets triggers in its description so it fires on
   its own; a rule gets the problem and the agreement; a gotcha gets the
   symptom and the fix. Done when the next session of any project would
   find it without the owner's prompting.
4. **Record it in the ledger**
   [`docs/playbook/HARVEST.md`](../../../docs/playbook/HARVEST.md): date,
   project, what repeated, where it landed. The ledger travels with the
   playbook into every repository — it is the cross-project memory.
5. **Offer it to the owner**, one line per candidate, inside the three
   options of P-08 — not as a separate essay. Done when the owner sees
   "repeat X → skill Y" and can say yes or no.

## When it fires

Not by mood. At three points of the ritual:
- **end of a work cycle** (P-08) — before the three options;
- **session handoff** (P-07) — before writing the handoff note;
- **immediately** when the owner says "again / every time / once more".

One cycle with no candidates is normal. Three cycles in a row with none is
suspicious: re-read the session.

## What not to extract

One-offs. The specifics of a single bug. Anything already covered by the
playbook or a skill (check `ls .claude/skills` and `grep` the playbook — a
duplicate is worse than nothing, because two sources drift apart).
