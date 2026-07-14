## Submission summary

This is a minor update (2.0.1). It refines the bundled Quarto Live slide decks
of the six *Basics* workshops (both the Chinese and English editions): a
consistent `goldenBlack` theme, incremental reveals, standardised outline,
exercise and recap sections, a shared subtitle and institute, and layout fixes
so no closing slide is clipped. There are no changes to the package's R code,
exported functions, or the behaviour of `drhur()`.

## Test environments

- Local: Windows 11, R-devel (2026-06-17 r90169), x86_64-w64-mingw32

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
