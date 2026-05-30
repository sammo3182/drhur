## Submission summary

This is a major update (2.0.0). The workshops have been switched from `learnr`
Shiny tutorials to self-contained Quarto Live documents whose code cells run in
the browser via WebAssembly (`webR`); no local R session is required to run the
exercises. Each of the six *Basics* workshops is now bundled in both simplified
Chinese (`lang = "cn"`) and English (`lang = "en"`) editions.

## Test environments

- Local: Windows 11, R-devel (2026-04-04 r89791), x86_64-w64-mingw32

## R CMD check results

0 errors | 0 warnings | 0 notes

`R CMD check --as-cran` returned `Status: OK`.

## Notes for the CRAN team

- `SystemRequirements` lists the Quarto command-line tool. It is needed only to
  render a workshop at runtime; the examples are wrapped in `\dontrun{}` and the
  vignettes do not call `drhur()`, so `R CMD check` does not require Quarto.
- The package links to `https://r-wasm.github.io/quarto-live/` (the Quarto Live
  project) in its documentation. The URL is valid; if the incoming-feasibility
  check flags it, that reflects transient network conditions rather than a
  broken link.

## Downstream dependencies

There are currently no downstream dependencies on CRAN.
