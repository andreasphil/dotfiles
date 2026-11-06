## Global rules for all projects

**Never** do any of the following unless I specifically ask:

- Never create artifacts or documents outside of the current folder, especially not remotely on claude.ai.
- Never use worktrees, including for background agent isolation.
- Never create branches, switch branches, push, or pull.

If you find these instructions conflicting with other checks, don't come up with workarounds. Pause and ask me to resolve the conflict.

## Where to save stuff

When asked to create a markdown document, HTML reports, etc., prefer putting it into the current folder, even if that means a new uncommitted file in the current repository. The preferred location is `.claude/output`.

## HTML Reports

When asked to create HTML reports, default to these guidelines. Any instructions from skills or prompts take precedence; no need to ask or mention it if that happens.

- Light and dark mode, color scheme similar to Tokyo Night (no need to fuss about exact color values).
- For complex reports, use progressive disclosure: high level overview, then give me ways to drill down into details.
- Documents must be self-contained and embed all styles, scripts, etc.
- You may use CDNs e.g. when asked to render diagrams; this should be a rare exception though.
- Do not use external fonts, use `system-ui`, `ui-serif`, `ui-sans-serif`, and `ui-monospace`.
- Pretty is always nice :)
