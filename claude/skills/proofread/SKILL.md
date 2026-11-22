---
name: proofread
description: Proofread and edit the user's own writing (Slack posts, messages, READMEs, docs, tickets, concept docs, notes) so it reads cleanly and still sounds like them. Use when the user asks to proofread, edit, polish, clean up, "go over", or fix typos, grammar, or language in their own text. For AI-generated text, use the `rewrite` skill instead.
---

# Proofread

The text is the user's own. Keep their voice, content, and structure. Fix the language, including the bad habits listed below. The author knows the content better than you do.

## Ground rules

- Never change content. Do not add, remove, or reprioritize points, opinions, requirements, or scope. Flag content problems (contradictions, missing pieces, claims that look wrong) in the summary instead.
- Keep headings, order, paragraphs, lists, and tables. Restructure a paragraph only when it is truly a mess, and say so in the summary.
- Inside a paragraph, rework sentences as much as needed.
- When the intended meaning is unclear, flag it instead of guessing.
- Leave these exact: URLs, code and inline code, identifiers, commands, file names and paths, config keys and event names, ticket IDs, quoted errors and log lines, product and proper names, titles of linked pages, UI labels, wiki links (`[[...]]`), callout syntax (`> [!NOTE]`), and text in other languages.

## Match the document type

Work out the type from the content. Everything should still sound like the same person.

- **Personal messages:** Fix typos, capitalization, and long sentences. Keep slang, stretched words ("sooo"), and emoji.
- **Slack and team posts:** Conversational and first person, but tidy.
- **READMEs, docs, how-tos:** Plain and direct. Imperative for instructions, condition before command ("If the build fails, read the log"). Fewer softeners and hedges.
- **Concept docs, decision records, tickets:** Clear and confident, especially in recommendations.

## Fix

1. **Typos and grammar.** Misspellings, doubled or missing words, agreement, tense, prepositions, articles. Convert HTML entities from exports (`&amp;`, `&#39;`) to plain characters.
2. **Capitalization and spelling.** Capitalize sentence starts, also in casual text. Sentence case for headings, link labels, and list items unless it is a proper name or an exact title. US English, consistently.
3. **Long sentences.** This is the biggest problem. Split run-ons, comma splices, and multi-clause sentences so each sentence carries one idea. Two independent clauses joined by ", and" usually become two sentences. Aim for short declarative sentences. Starting a sentence with "But", "And", "So", or "Also" is fine and keeps split sentences connected.
4. **Asides.** The user overuses parentheses and `---` asides, which makes sentences complicated. If an aside can become its own sentence or be cut without rewriting the whole paragraph, do it. Keep the ones that read well. Write dashes as `---` without spaces, and convert `—` or ` - ` used as a dash.
5. **Hedging.** Keep hedges that express real uncertainty ("I haven't tested this", "I'm not a security expert"). When the sentence is really a recommendation or a position, state it with confidence: "I think we should probably consider X" becomes "I'd recommend X". If you can't tell which it is, keep it and flag it.
6. **Filler and abbreviations.** Drop "just", "simply", "easily", "basically", "actually", "really" where they add nothing. Spell out "e.g." and "i.e.". Replace "etc." and trailing ",..." with the actual items, or cut them. Replace a sloppy "..." at the end of a thought with a period. Replace "however" with "but", or restructure.
7. **Softeners.** "Pretty", "quite", "a bit" are fine. Thin them out when several pile up.
8. **Lists.** Fine in moderation. Merge bullets back into prose when they are really one connected thought, or when a list has only two short items. Never turn prose into a list.
9. **Terminology.** One term and one spelling per concept ("backend", not also "back end").
10. **Active voice.** Say who does what, unless the actor is unknown or irrelevant.
11. **Plain, concrete words.** Replace vague words with the concrete meaning when it is clear from context. Cut adjectives, adverbs, and jargon that carry no information. Prefer the simple word: "use" for "utilize" or "leverage", "help" for "facilitate", "show" for "showcase", "also" for "additionally". Say "is" or "has" instead of "serves as", "stands as", "boasts", or "features".
12. **Link text.** Name the destination, never "here" or "click here".

## Keep

These are the user's voice, not mistakes:

- Contractions.
- "I" or "we", as written. Only make them consistent within a document.
- Bold key sentences, bold labels, emoji, italics, and scare quotes, if the user wrote them. Never add them.
- Idioms and informal phrasing that fit the register.

## Output

- For a file, edit it in place. For pasted text, return the edited text in chat.
- Then write a short prose summary: the kinds of changes with a few examples, what you left unchanged on purpose, hedges you flagged, and content issues. Mention any edit that might change the meaning so the user can revert it.
