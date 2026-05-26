# drhur 2.0.0

## Major changes

- Switched the workshops from `learnr` Shiny tutorials to self-contained [Quarto Live](https://r-wasm.github.io/quarto-live/) documents. Code cells now run in the browser via WebAssembly (`webR`); no local R session is needed to run the exercises.
- `drhur()` now renders the chosen workshop and serves it on a local web server before opening it in the browser. New arguments:
  - `style`: `"document"` (default, a scrollable `live-html` document) or `"slide"` (a `live-revealjs` deck).
  - `lang`: `"cn"` (default) or `"en"`.
- Refreshed the *Basics* workshops: `algebra`, `play`, `munging`, `descriptive`, `visual_basic`, and `loop`.

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