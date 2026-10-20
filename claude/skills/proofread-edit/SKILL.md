---
name: "proofread-edit"
description: Proofread and lightly edit a draft (technical notes, tickets, specs, concept docs, READMEs, Confluence/Obsidian pages) for typos, grammar, clarity, readability, and consistent wording, while staying close to the original. Use this skill whenever the user asks to proofread, copyedit, polish, clean up, "go over", fix typos/grammar/language in, or edit a draft for clarity or consistency, even if they don't say "proofread" explicitly. Delivers the result as a file (markdown by default) plus a short summary of changes and any content issues spotted.
---

# Proofread & edit

A light-touch editing pass for working documents. The goal is a draft that reads cleanly and consistently while still sounding like the author wrote it. The author knows the content better than you do, so improve the language, not the substance.

## Principles

**Stay close to the original.** Keep the structure, headings, order, lists, tables, and meaning. Rephrase where a sentence is wrong, unclear, clumsy, passive without need, or overly long. If a sentence is already fine, leave it alone. A good edit feels like the same document with the rough edges removed.

**Never change content decisions.** Do not add, remove, or reprioritize requirements, options, opinions, or scope. If you notice a content problem (a contradiction, a missing piece, a claim that looks wrong), leave the text as is and flag it in the summary. For example, one section says to remove some data while another proposes tracking it.

**Preserve things that must not change:** URLs and anchors, code identifiers and inline code, file names, API/config names, event and property names (e.g. `$pageview`), ticket IDs, the actual titles of linked tickets/pages, proper nouns, wiki links (`[[...]]`), callout syntax (`> [!NOTE]`), and text in other languages (such as German titles or file names).

## Editing checklist

Work through the whole document for each of these:

1. **Typos and spelling.** Fix misspellings, stray capitals mid-sentence, and doubled or missing words. Keep the document's variety of English (US vs. UK) consistent.
2. **Grammar.** Fix agreement, tense consistency (e.g. "In the past … was", not "would be"), wrong prepositions ("different from", not "from to"), articles, and punctuation (e.g. put a parenthetical reference inside the sentence, before the period).
3. **Consistent terminology.** Pick one spelling per term and use it everywhere: "backend" not "back end", "page view" in prose with the code name for the event, "autocapture" not "auto capture", one noun for the same concept ("document kind" vs. "type"). Hyphenate compound modifiers ("analytics-related metrics").
4. **Active voice and simple verb forms.** Say who does what. "The PostHog instance is declared at module scope" becomes "We declare the PostHog instance at module scope". "Tracking should be rewritten" becomes "We should rewrite tracking". Prefer plain verbs over noun constructions ("capture events" rather than "gate capturing"). Keep a passive only when the actor is unknown or irrelevant, or when the active version reads worse.
5. **Replace vague words.** Swap vague or hand-wavy phrasing for the concrete meaning the author clearly intended. For example, "a number of" becomes "several", "fragile" becomes "breaks easily", "gate capturing" becomes "only capture events after the user gives consent", "aggregate X and Y" becomes "X count divided by Y", and "Everything else should be turned off" becomes "Any autocapture beyond these metrics should be turned off". Only do this when the intended meaning is clear from context. If it is not, flag it instead of guessing.
6. **Short sentences.** Split long, multi-clause sentences into shorter ones, and give each sentence one main idea. There is no fixed word limit, so use judgement. Keep a longer sentence when it flows well and splitting it would feel choppy or repetitive. Linking words like "As a result", "However", and "also" keep the split sentences connected.
7. **Clarity and readability.** Cut filler and redundancy, and make sure each paragraph or bullet is easy to follow on first read.
8. **Descriptive link text.** Replace "see [here](...)" and "click here" with text that names the destination.
9. **Tone and voice.** For shared team documents, use the team "we" rather than a singular "I" ("We have not investigated this in detail yet", not "I haven't looked into this"), and write contractions out ("is not", "do not"). If the whole document is clearly casual or personal, match that instead.
10. **Consistent capitalization.** Use sentence case for link labels, table entries, and list items unless something is a proper name or an exact page/ticket title.
11. **Tables.** Fix wording inside cells with the same rules. Use semicolons between distinct clauses in a note, and realign the columns so the raw markdown stays readable.
12. **Encoding artifacts.** Convert HTML entities that leaked in from exports (`&amp;`, `&#39;`, `&gt;`) back to plain characters.

## Output

- Write the edited document to a file in `/mnt/user-data/outputs/`. Keep the source format: markdown in, markdown out. Name the file after the document or ticket (e.g. `RISDEV-10718-posthog-tracking.md`).
- Present the file with `present_files`.
- After the file, write a short prose summary (no bullet lists) covering:
  - the typos fixed, with a few concrete examples
  - terminology that was made consistent
  - the kinds of clarity edits made
  - anything deliberately left unchanged and why (e.g. a ticket title)
  - **content issues flagged for the author**, such as contradictions or open questions
- If an edit changes meaning noticeably, or there is a stylistic choice the author might disagree with, mention it so they can revert it.

## Follow-up requests

If the user asks for further suggestions, give a short list of optional, concrete tweaks, each naming the location and the proposed wording. If they ask you to apply them, update the same file in place, verify the result (e.g. grep for leftover contractions if you switched tone), present it again, and briefly confirm what changed.
