---
name: html-report
description: Write a self-contained HTML report (research findings, investigations, proposals, audits, triage results, code walkthroughs) in the user's preferred style. A quiet single reading column, numbered overview cards, sections with status chips, and collapsible detail layers. Light and dark mode, system fonts only. Use whenever the user asks for an HTML report, an HTML write-up or summary, or "put this into a report", unless another skill prescribes its own format.
---

# HTML report

Reports in this style read like a well-kept engineering notebook. They are calm, dense and easy to scan. The reader gets the whole picture from the top of the page, then opens only the parts they care about.

The reference implementation is `template.html` next to this file. Read it first and copy its `<style>` block and script as the starting point. It holds every component described below. You don't have to match it exactly: drop components the report doesn't need, and add small ones in the same spirit when the content calls for it.

## Ground rules

- **Location:** save to `.claude/output/<kebab-case-topic>.html` in the current project. If that folder can't be written (for example a read-only mount in a sandbox), ask the user where to put it. Don't fall back to `/tmp`, the home folder or an artifact on your own. Never publish to claude.ai unless the user asks for that.
- **Self-contained:** one file, with all CSS and JS inline. No external stylesheets.
- **Fonts:** never load web fonts (no Google Fonts). Use `ui-serif`, `system-ui` / `ui-sans-serif` and `ui-monospace` stacks, as in the template.
- **CDNs:** only as a rare exception, for example Mermaid when a diagram adds real value. Pin an exact version (`mermaid@11.4.1`).
- **Light and dark mode:** both are required. Use the token setup from the template.
- **Progressive disclosure** for anything beyond a short report: overview first, then drill-down.
- If another skill or the prompt prescribes a format, follow it instead. You don't need to mention the deviation.

## Information architecture

Three layers. Each layer must make sense without opening the next one.

1. **Header and overview.** An eyebrow (`project · kind of report`), an `h1` title, a one- or two-sentence lede saying what the report covers and what it concludes, a meta row (as-of date, scope, branch or data source), and "Expand all" / "Collapse all" buttons. Below that comes a grid of **numbered cards**, one per section. Each card has a number, a title, a 1–2 sentence summary and a status chip. The cards are links to their sections.
2. **Section summary (always visible).** Each section starts with a head row (mono number, `h2`, optional status chip), then a short paragraph with the finding, then at most one short list or one table. A reader who only skims these should know everything that matters.
3. **Details (collapsed).** A stack of `<details>` elements holds evidence, code, alternatives considered, consequences, per-step breakdowns and test lists. Every `<summary>` is a concrete label ("Approaches considered", "Code: the composable"), optionally followed by a muted `.hint` with the file path, sample size or scope. Nest a second level only rarely. Nested details get the sunken background automatically.

Typical section order for a technical investigation: what was done or found → current state (inventory) → problems → proposal → migration steps → open questions. The last section is usually **Open questions**: a plain list of decisions for the team.

Short reports (one topic, a few findings) can skip the overview grid and the expand/collapse buttons. Keep the header, the section structure and the visual language.

## Visual language

- **Layout:** one reading column, `max-width: 880px`, 48px between major blocks, a 16px side gutter (with safe-area insets), 40px top and 80px bottom padding. Paragraphs are capped around 68ch. No sidebars, no sticky header, no hero.
- **Palette:** cool blue-grey neutrals (`--bg`, `--surface`, `--sunken`, `--rule`, `--fg`, `--muted`), one navy accent (`--accent`, `--accent-soft`), and three semantic pairs: `good`, `warn`, `bad`, each a strong color with a `-soft` background. Dark mode uses deep slate surfaces and lighter, desaturated versions of the same hues. Don't invent new hues. Reuse the tokens.
- **Type:** a serif display face for `h1`, `h2` and card titles. A sans face for the body and for `h3` inside sections. Mono for section numbers, file paths, inline code and code blocks. Use a small modular scale (`--step--1` … `--step-3`, body 15px, line-height 1.6). Headings use `text-wrap: balance`. The eyebrow is small, uppercase, letter-spaced and muted.
- **Surfaces:** white or surface cards with a 1px `--rule` border and an 8px radius (6px for code and tables). No shadows, no gradients. Hover just turns the border or background accent-colored.
- **Section separation:** a top border rule plus 32px padding, not boxes.
- **Status chips:** small pills with a soft background and strong text. Map them by meaning: `good` = done / chosen / passing; `warn` = later / not started / needs decision; `bad` = broken / rejected / missing; `info` = inventory / proposal / neutral. Labels are short and plain: "Implemented, uncommitted", "Proposal", "Inconsistent", "For the team".
- **Motion:** only the chevron rotation on `<details>`, turned off under `prefers-reduced-motion`.

## Components (all in the template)

| Component                                        | Use for                                                                |
| ------------------------------------------------ | ---------------------------------------------------------------------- |
| `.overview` grid of `a.card`                     | section index with status at a glance                                  |
| `section.topic` + `.topic-head`                  | numbered section with an optional chip                                 |
| `.disclosures` > `details` > `summary` + `.body` | drill-down layers; `.hint` for muted context                           |
| `.file` + `pre.code`                             | code excerpts, with the file path label above                          |
| `.table-wrap` > `table`                          | inventories, comparisons, verdicts; `td.num` for right-aligned numbers |
| `.callout` + `dl.terms`                          | definitions of terms used in the report, key caveats                   |
| `ol.stages`                                      | numbered sequences such as pipeline stages or a flow                   |
| `.diagram` + `.caption`                          | Mermaid or inline SVG diagrams, with a caption explaining the arrows   |
| `.chip`                                          | status, verdict in a table cell                                        |

Comparison tables of alternatives usually have the columns _Approach · Verdict (chip) · Reason_. Inventory tables usually have _What · Applies to · Where (path)_.

## Content and voice

- Plain, direct English with short sentences. Write findings in first person where it's honest ("I fetched 30 laws and counted…", "I didn't reproduce this").
- Be concrete: real counts, file paths in `<code>`, exact names. Say what was verified and how ("1646 unit tests pass; the new E2E test fails when the change is turned off").
- Mark uncertainty plainly ("may never happen in practice, but nothing guarantees the order").
- Show code as short, real excerpts. Use `…` for elisions and HTML-escape everything (`&lt;`, `&gt;`, `&amp;`). Label proposals as such in the summary hint ("proposal, not implemented").
- Bold lead-ins in list items (`<strong>Where:</strong> …`) for scannable bullets.
- Apply the `unslop` skill to the prose if it's available.

## Mechanics checklist

- `<!doctype html>`, `lang`, charset, a viewport with `viewport-fit=cover`, a short `<title>` (2–4 words).
- A one-line CSS comment at the top describing the layout.
- Tokens on `:root`. Dark values under `@media (prefers-color-scheme: dark) { :root:not([data-theme="light"]) {…} }` and again under `:root[data-theme="dark"]`, with `color-scheme: dark`.
- Visible `:focus-visible` outlines on links, buttons and summaries. `aria-label` on the overview `nav`.
- Works at 320px width: no horizontal page scroll, tables and code scroll inside their wrappers, and `dl.terms` collapses to one column.
- If you use Mermaid, initialize its theme from the effective color scheme (see the template script).
- Open the file in a browser (e.g. with `playwright-cli`) in light and dark mode at desktop and phone width if a browser is available. Fix overflow and contrast problems before reporting the path.
