# Playbook: how we build (cross-project)

This is **not** about one project. These are working agreements that hold in
every project. A project's own decisions live in that project's repository;
only what transfers between projects comes here.

This file is canonical. Improve it here, then copy it into product
repositories the same way skills are copied (`.claude/` + a SessionStart
hook). Every agreement has a number (P-NN) so it can be cited and replaced
by a newer version instead of re-argued. Numbers are stable and never reused.

Structure: **start ritual → working rules → end ritual**.

---

## Start ritual

### P-00 | What a session does first (run by a hook, not by memory)

`.claude/hooks/session-start.sh` injects the ritual into context:

1. **Read context** — `CLAUDE.md`, `PROJECTS.md`, and in a product
   repository its handoff note (where the project stopped) — before acting.
2. **Credential inventory by name, never by value.** The hook prints which
   standard variables are present and which are missing (edit the list in
   the hook). If a task needs a missing key, the agent says so once and says
   **where** it belongs. A value is never requested in chat.

### P-01 | Access model: one scoped key per project

**Problem.** Manual "log in, delete, change" steps in third-party dashboards
stall a project. The cause is not a missing key but where it lives and what
it may do.

**Agreement.**
1. At project start the owner creates **one API token scoped to the
   project's resources** (for a web project: one zone or domain) with the
   permissions the work needs. Never an unscoped global key.
2. The token goes where the agent can use it without seeing it:
   an **environment variable** if the agent calls the API from the terminal,
   or a **CI secret** if a workflow does the work. **Never in chat** — the
   transcript is stored, and a key pasted there has leaked for good.
3. **Map access at the start**, not along the way: the list of services and
   keys and **where each lives** (variable or secret name) goes into the
   project's `CLAUDE.md` under "Keys and services".
4. The agent does the routine itself and prints the token's **permissions**,
   never the token.
5. At project end the owner deletes the token with one click. The blast
   radius was one project; there is nothing else to roll back.

### P-01b | A key being present is not a key being usable

**Problem.** "Key present" only means a non-empty variable. A token can be
"active" and see no accounts; a deploy secret can be alive and allowed to do
nothing. A day goes on guessing permissions a provider would have reported
in a minute.

**Agreement.** Before relying on a key, fixing a workflow that fails
silently, or asking the owner to press a button: **probe capability**, not
presence — call the provider's token-verify or a harmless read endpoint and
read the answer. Make the error print before a step dies (under `bash -e`, a
bare `X=$(cmd)` kills a step without a word). Replace an owner button with a
push trigger where possible. Record the probe result in the project's
`CLAUDE.md` so the next session reads instead of asking.

---

## Working rules

### P-02 | Autonomy, and what is left to the owner

- The agent acts and verifies the result itself. The owner gets only what
  physically needs a human: a toggle with no API, an approval, creating an
  account.
- Every remaining manual step comes with the **exact reason** it cannot be
  automated (e.g. the integration gets `403` when dispatching a workflow →
  one click is needed; fixed by granting the missing permission).
- Destructive actions (delete, overwrite) are shown before they run — what
  exactly goes. Data comes with a source and a date.

### P-03 | Check against reality, not memory

- Facts are checked against the live site or API (`curl`, screenshot, server
  response), not recalled. "The deploy returned" is not "the deploy
  arrived": post-deploy checks must know how to wait.
- What the repository doesn't say, the server response often does
  (headers, redirects, status).

### P-04 | Memory discipline

- Project decisions, status, risks, backlog and the session handoff live in
  the project's own docs. Cross-project lessons → this playbook.
- Memory is kept in sync with the code: periodically compare what the docs
  claim with the repository and the live site, and fix the drift.

### P-05 | Communication

- Terse by default.
- Full prose, uncompressed, for security warnings, irreversible actions and
  multi-step instructions — wherever compression risks a wrong step.
- Manual steps as direct clickable links, not "go find the setting".

### P-09 | A repeat becomes a method (harvest)

**Problem.** Project after project started from a blank page. Lessons were
written into one repository's decision log and died there; the next project
never saw them.

**Agreement.** A repeat is: the same steps a second time, the same
explanation, the same request to the owner, a "lesson" entry in a decision
log, or the owner saying "again" / "every time". At three points of the
ritual the agent runs the `harvest` skill: at the end of every work cycle
(before the three options of P-08), before a handoff (P-07), and
immediately on "again". Every repeat gets a home: a skill (a procedure for
all projects), a playbook rule (an agreement), or a `CLAUDE.md` gotcha (a
fact about one repository). The entry goes into `docs/playbook/HARVEST.md`,
the cross-project ledger. Three cycles with no candidate are a reason to
re-read the session, not a sign of cleanliness.

### P-10 | Print what you computed before you write assertions

**Problem.** Tests fail while the code is right, because the assertion
encoded a wrong assumption about behaviour (e.g. "the balance falls during a
promo period" — it grows, because the promo payment is below the interest).
A red test eats a cycle and pushes you to "fix" correct code.

**Agreement.** For a new pure function, first **run it on a reference input
and print every output**, read them, and only then write assertions — from
what you saw, not from what you expected. If what you saw contradicts the
expectation, first explain why the model is right; if you can't, it's a bug.
The contradiction is often the most valuable fact you found.

Corollary: judging by a **slice** of output (`head`, `tail`, the last log
lines) is the same sin. Full output is cheaper than a diagnosis from a
fragment.

### P-11 | Zero out of dozens — change the method, not the effort

**Problem.** Guessing candidate sources "from memory" returned 0 of 26.
Changing method — search results to find the sources' real domains, then a
rendering reader — returned 4 of 5 in one pass.

**Agreement.** The threshold is roughly ten identical failures in a row.
After that, stop adding attempts and ask what is wrong with the **way**:
usually the source of candidates (guessing instead of searching), the read
layer (raw fetch instead of render), or the premise itself. Record the
change of method and its result so the next session starts with what works.

### P-12 | Data opens a gate, never a hand

**Problem.** A target number tempts you to bend the rule to fit it — e.g.
publishing a page the quality gate doesn't allow yet, just to hit a page
count.

**Agreement.** A quality threshold lives in **one exported function** that
every surface reads (the page's robots directive, the sitemap, the notice on
the page). It then opens itself when the data is sufficient, guarded by an
invariant test ("in sitemap <=> gate passed"), not by a manual edit.

Corollary: **a target number is not a reason to open a gate.** Pick another
item the gate allows, or admit the target isn't met yet. Changing the
threshold so the data passes is fitting the rule to the data.

### P-13 | A check's trigger reads the same input as the check

**Problem.** A script decided "page unreadable, pay for a render" from raw
text, but compared values from a cleaned, length-limited excerpt. When the
number sat in a longer block, the raw text said "data present", no render
ran, and the row reported "no data". The check silently stopped checking —
the most expensive kind of breakage, because it looks like work.

**Agreement.** The condition that triggers a check and the check itself take
**the same input**: one normalisation function, one list, one sample. If the
trigger needs a raw view and the check a cleaned one, those are two
different facts and get two different names.

Second lesson: **"could not read" is not "no data".** A network failure, an
empty render and a page without numbers are three outcomes, and a report
must tell them apart, or a tool's silent failure reads as a fact about the
world.

### P-14 | Long work: cut it into chunks, read time from the clock

**Problem.** A long crawl outlived the shell that launched it; output piled
up in a `tail` buffer and never appeared. `pkill -f <name>` killed the
agent's own command too, because its command line contained the same text.
And a build was declared "stuck for twenty minutes" without looking at the
clock — it had been running for twenty-three seconds. The number of turns
feels like time and isn't.

**Agreement.**
- A long crawl accepts a slice (`START`/`END`, page, chunk) and prints each
  result immediately. A chunk fits in one call; a partial result beats a
  complete one that never arrives.
- Write output straight to a file, not through `| tail` or `| head`: a
  pipeline buffer flushes at the end — that is, never, if the process dies.
- Before calling something stuck: `date` and the start timestamp.
- Kill by exact PID from `pgrep -f "<exact command>"`, never `pkill` by a
  substring that also appears in your own command line.
- Wait with one conditional call — `until <check>; do sleep 15; done`, then
  the output — not with a chain of `sleep; cat` turns.

### P-15 | A derived number is labelled as yours and checked against someone else's

**Problem.** Between a published source and the answer there is often
something of ours: a coefficient, a split of a range into tiers. Presenting
it unlabelled passes off our assumption as the source's fact.

**Agreement.** A derived number the source didn't publish is:
1. **called ours** in the text itself ("our coefficient, not the source's");
2. **checked against an independent publication** — usually a published
   total; if the parts don't add up to it, the page says so;
3. **left as an input** where the reader may know better — a slider, not a
   constant.

Same root as session rule 4 ("numbers carry a source") and P-13.

### P-16 | An instruction that must be remembered will be skipped

**Problem.** Rules that said "X is available and should be used when
appropriate" were written down and still skipped, more than once. Each time
the rule required the model to **remember** and to **decide** the case
applied.

**Agreement.** If a rule must always hold, it is not phrased as a reminder.
Three levels, most reliable first:

1. **Put the content into context** — a hook injects it verbatim; there is
   no "load the skill" step to skip.
2. **Name the trigger and the action as a ritual step** — not "for large
   work", but "before planning any change that touches more than one file,
   run X". Whoever skips the rule is the same one judging "large".
3. **Check the thing exists** and say so if not — a hook checks for the
   file and says where to get it.

"X is available and should be used when appropriate" is not a rule, it is a
hope. Kin to P-12: data opens the gate, not a hand; here, the ritual runs the
step, not memory.

---

## End ritual

### P-07 | Session context and handoff

- The agent watches how full the context is. Approaching the limit (rule of
  thumb ~75 %) or when a compaction summary appears, it **immediately**:
  1. updates the handoff note to "you can continue from here";
  2. gives the owner a **ready prompt** for a new session (what to open,
     what is done, the next node);
  3. suggests moving to a new session before quality degrades.
- Honest caveat: the exact percentage can't be read from inside a session;
  go by signs (length, compaction). So keep the handoff note current after
  **every** closed node, not only near the limit.

### P-08 | Every work cycle ends with three options

- At the end of a node or iteration, the agent offers **exactly three**
  next steps — through a picker (AskUserQuestion), not prose; the first is
  the recommended one, marked as such. The owner picks, the agent executes.
- Harvest candidates (P-09) appear as one line inside those options, not as
  a separate essay. The `Stop` hook enforces this once per cycle.
