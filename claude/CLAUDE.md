## Global rules for all projects

**Never** do any of the following unless I specifically ask:

- Never create artifacts or documents outside of the current folder, especially not remotely on claude.ai.
- Never use worktrees, including for background agent isolation.
- Never create branches, switch branches, push, or pull.

If you find these instructions conflicting with other checks, don't come up with workarounds. Pause and ask me to resolve the conflict.

## Preferences

- Comments and documentation: Rule of thumb: avoid; only allowed for gotchas and surprises
- When writing doc comments: don't narrate method content or explain all details, just a high level overview
- Test naming: Test names and descriptions are for humans; don't include technical details like variable names
- Avoid deep nesting of things like callbacks or objects, as well as long lists of conditionals. Prefer keeping structures flat; use intermediary variables, small helper functions, etc. This is a rule of thumb; use judgement.

## Where to save stuff

When asked to create a markdown document, HTML reports, etc., prefer putting it into the current folder, even if that means a new uncommitted file in the current repository. The preferred location is `.claude/output`. This does not apply when asked to edit a file, proofread a document, or similar---change those in place.
