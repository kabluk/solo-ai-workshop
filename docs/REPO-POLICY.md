# Repository policy

Adopted after an audit that found unrelated projects sharing one public
repository and other projects split across branches of a single repository.

## Rules

1. **One project, one repository.** A project is anything with its own
   domain, its own users or its own economics. A folder inside another
   project's repository, or a branch of it, cannot be a project.

2. **Branches are for versions of one project, not for different
   projects.** Two products on two branches of one repository are two
   histories that will never merge, sharing a namespace. Such a repository
   cannot be cloned whole, cannot get sane CI, and cannot be handed to an
   agent session without caveats.

3. **Tooling lives apart from products.** Agents, commands, hooks and
   skills have a canonical home (this workshop, or a dedicated toolkit
   repository). Products receive a *vendored copy* — symlinks do not
   survive cloud sessions. When the canonical copy changes, re-copy and
   commit; a silent drift between copies is only found by a deliberate diff.

4. **Private by default.** Make a repository public deliberately, for a
   reason you can name. It cannot be un-published: forks and caches remain.

5. **One repository, one `CLAUDE.md`,** describing this project and no
   other. A sentence like "main holds a different, unrelated project — don't
   mix them up" means the repository must be split, not annotated.

6. **Archive instead of delete.** A finished repository is archived: its
   history stays readable, and it stops pretending to be alive.

## Naming

Lowercase, hyphen-separated, and equal to the domain without its TLD where
there is a domain: `parcelping` for `parcelping.com`.
