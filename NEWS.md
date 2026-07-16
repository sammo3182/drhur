# drhur (development version)

## Licence

- Relicensed from MIT to Creative Commons Attribution-NonCommercial 4.0
  International (CC BY-NC 4.0). The workshop materials may still be shared and
  adapted with attribution, but no longer for commercial purposes. Versions
  released up to and including 2.0.1 remain available under the MIT terms they
  shipped with.

# drhur 2.0.1

## Slide improvements

All six *Basics* workshops (both the Chinese and English editions) received a
consistent redesign of their reveal.js slide decks:

- Applied the `goldenBlack` theme and enabled incremental reveals (`incremental: true`) for step-by-step pacing.
- Standardised the opening slide as an outline (`## Outline` / `## 提要`), moving the "Chapter highlights" bullets out of the callout and showing each chapter's research question as a fragment.
- Renamed the practice sections to *Exercise* (`## Exercise` / `## 现学现练`) on a dark (`#43464B`) background.
- Added a closing recap slide (`## Recap` / `## 小结`).
- Set a shared subtitle ("Learning R with Dr. Hu and His Friends Workshop Series") and institute ("Department of Political Science, THU" / "清华大学政治学系") across all decks.
- Reflowed overfull closing slides into columns so their content is no longer clipped, and removed redundant `---` separators before slides that already begin with a heading.

# drhur 2.0.0

## Major changes

- Switched the workshops from `learnr` Shiny tutorials to self-contained [Quarto Live](https://r-wasm.github.io/quarto-live/) documents. Code cells now run in the browser via WebAssembly (`webR`); no local R session is needed to run the exercises.
- `drhur()` now renders the chosen workshop and serves it on a local web server before opening it in the browser. New arguments:
  - `style`: `"document"` (default, a scrollable `live-html` document) or `"slide"` (a `live-revealjs` deck).
  - `lang`: `"cn"` (default) or `"en"`.
- Refreshed the *Basics* workshops: `algebra`, `play`, `munging`, `descriptive`, `visual_basic`, and `loop`. Each is now bundled in both simplified Chinese (`lang = "cn"`) and English (`lang = "en"`) editions.

## Under the hood

- Removed the dependency on `learnr`; added `quarto` (Imports) and `servr` (Suggests, used only to serve a workshop locally). The [Quarto](https://quarto.org) command-line tool is now a system requirement.

# drhur 1.1.0

## New function

- Added English versions for the released version

## Bug fixed
- Fixed the problem that causes the "play" chapter unable to be compiled in certain areas of the world.
- Fixed the [issue](https://github.com/sammo3182/drhur/issues/15) caussed by `ggrader`
- Revising the help file
- Revised the vignette