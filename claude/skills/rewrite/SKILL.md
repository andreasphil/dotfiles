---
name: rewrite
description: Rewrite AI-generated technical text (docs, READMEs, tickets, concept docs, reports, PR descriptions) so it reads like the user wrote it, plain and concrete without AI tells. Use when the user asks to unslop, de-slop, humanize, or rewrite generated text. For the user's own writing, use the `proofread` skill instead.
metadata:
  credits: "Based in part on unslop by Lauren Tan (https://github.com/cursor/plugins/tree/main/pstack, MIT) and SimpleEnglish by AminBlg (https://github.com/AminBlg/SimpleEnglish, MIT)."
---

# Rewrite

Turn AI-generated text into text that sounds like the user wrote it. Keep the facts and the structure. Change the language.

## Ground rules

- Keep the meaning and the facts. Never invent facts, numbers, sources, or opinions. When the text needs the user's own take or a detail the source does not give, leave a marker like `[TODO: your take on X]`.
- Rework sentences as much as needed.
- Leave these exact: URLs, code and inline code, identifiers, commands, file names and paths, config keys and event names, ticket IDs, quoted errors and log lines, product and proper names, titles of linked pages, UI labels, wiki links (`[[...]]`), callout syntax (`> [!NOTE]`), and text in other languages.

## Match the document type

- **READMEs, docs, how-tos:** Plain and direct. Instructions in the imperative, one instruction per sentence, condition before command ("If the build fails, read the log"). Put a warning before the step it applies to.
- **Concept docs, reports, tickets, PR descriptions:** Clear and factual, confident in recommendations.

## The voice

- First person when the user is the author, for example in reports or tickets ("I tried", "I'd go with X"). "We" for team documents. Use contractions.
- Lead with the point, then give the context.
- Short declarative sentences, one idea each. Starting a sentence with "But", "And", or "So" is fine.
- Concrete over abstract: names, numbers, links, the actual mechanism. Replace phrases that name a feeling ("SQL you can read", "stays close at hand") with what the thing does. If a sentence could appear unchanged in another project's docs, it says nothing. Cut it.
- Confident when recommending. Hedge only real uncertainty, and say it plainly ("I haven't tested this"). Collapse hedge stacks: "could potentially" becomes "can", or a plain statement.
- Mechanics:
  - US spelling, sentence-case headings, straight quotes.
  - Write dashes as `---` without spaces, and use them rarely.
  - Keep parentheses rare.
  - Use lists only for truly parallel items. Prefer prose otherwise, and never nest lists.
  - No emoji and no bold for emphasis. No bold labels like "**Performance:** Performance improved...". Turn those into plain prose or a plain list.

## AI tells to remove

**Structure**

- **Saying what it isn't.** "A, not B", "X, never Y", "This isn't about X, it's about Y", "not just X, but Y". When B is obvious from A, say only what it is. Keep the contrast only when B is a misconception the reader likely holds.
- **Chaining with "and".** Two independent clauses joined by ", and" become two sentences. "The API fields keep their German names, and the context maps them to the English schema.org terms" becomes "The API fields keep their German names. The context maps them to the English schema.org terms."
- **Tails ending in "-ing".** ", making it...", ", ensuring...", ", allowing...", ", highlighting...". Write a new sentence with a real subject, or cut the tail.
- **Dramatic setups.** "The result: ...", "The catch? ...", rhetorical questions answered right away. State the point.
- **Synonym cycling.** Pick one term per concept and repeat it.
- **Recap endings.** Generic conclusions and summaries that repeat the text. Cut them, or state a specific next step.

**Words**

- **Puffery.** Pivotal, crucial, robust, powerful, comprehensive, seamless, intricate, landscape. Cut, or give the measurable property.
- **AI vocabulary.** Additionally, delve, enhance, foster, garner, interplay, leverage, utilize, showcase, underscore, streamline, facilitate. Use the plain word: use, help, show, also.
- **Fancy "is".** "Serves as", "stands as", "boasts", "features" become "is" or "has".
- **Abstract metaphor nouns.** Surface, substrate, vector, primitive, harness, scaffolding, north star, flywheel, paradigm. Name the concrete thing.
- **Filler.** "In order to" becomes "to". "Due to the fact that" becomes "because". "Prior to" becomes "before". "In the event that" becomes "if". "Allows you to" becomes "you can". "Out of the box" becomes "by default". "Under the hood" becomes "internally". Delete "it's worth noting that" and "it's important to".
- **Empty adverbs.** Delete "just", "simply", "easily", "seamlessly", "effortlessly". Replace an adverb that props up a weak verb with a stronger verb or the number.
- **Abbreviations and connectors.** Spell out "e.g." and "i.e.". Replace "etc." with the actual items, or cut it. "However" becomes "but".
- **Vague attributions.** "Experts say", "it is widely considered". Name the source or cut.

**Grammar**

- Active voice that names the actor: "queries are validated" becomes "the compiler validates queries".
- Simple tenses: "we have identified" becomes "we found".
- Verbs over nouns: "compress the file", not "perform compression of the file".
- Break noun chains of more than three words with prepositions: "the timeout value for the connection pool".
- Aim for at most 20 words per sentence in instructions and 25 elsewhere. This is a guideline, not a hard cap.

**Chat artifacts**

- "Great question", "Certainly!", "I hope this helps", "Let me know if...", disclaimers about limited information. Delete them.

## Process

1. Work out the document type and whose perspective it is written from.
2. Rewrite.
3. Read it again and ask what still makes it obviously AI-generated. Search for ", and", "not ", "never", "—", "---", "(", ":", ", " followed by an "-ing" word, "just", "e.g.", "however", bold, and emoji. Fix what you find.
4. For a file, edit it in place. For pasted text, return the result in chat. Add a short note only for `[TODO]` markers or changes that might shift the meaning.
