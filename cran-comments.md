## Submission summary

This is a licence-change release (2.0.2).

**This update changes the package's licence**, which CRAN policy asks to be
highlighted explicitly:

- Old licence: `MIT + file LICENSE`
- New licence: `CC BY-NC 4.0` (Creative Commons Attribution-NonCommercial 4.0
  International; SPDX `CC-BY-NC-4.0`)

There are no changes to the package's R code, exported functions, data, or the
behaviour of `drhur()`. The only changes are `DESCRIPTION` (`License` field),
the replacement of `LICENSE` with a `LICENSE.md` carrying the full licence text,
and the corresponding `NEWS.md` entry.

## Test environments

- Local: Windows 11, R-devel (2026-06-17 r90169), x86_64-w64-mingw32

## R CMD check results

0 errors | 0 warnings | 1 note

The one NOTE is the incoming-feasibility NOTE about the licence change itself:

```
* checking CRAN incoming feasibility ... NOTE
Maintainer: 'Yue Hu <yuehu@tsinghua.edu.cn>'

Change to non-FOSS package license.
New license:
  CC BY-NC 4.0
Old license:
  MIT + file LICENSE
```

This NOTE is expected and is addressed below.

## Notes for the CRAN team

- **The licence change is intentional and is the purpose of this release.**
  `drhur` is not a general-purpose software library: it is a set of teaching
  materials (Quarto Live workshop documents) distributed as an R package. The
  maintainer wishes to keep the materials freely available for teaching and
  self-study while reserving commercial exploitation. `CC BY-NC 4.0` expresses
  that intent; the MIT licence did not.

- **On the non-FOSS NOTE.** We are aware that `CC BY-NC 4.0` is recorded as
  non-FOSS in `share/licenses/license.db` and that the NOTE is therefore
  expected rather than accidental. The licence is a canonical entry in that
  database, so the `License` field is given in the standardised form with no
  accompanying `LICENSE` file. Should the CRAN team consider a NonCommercial
  licence unacceptable for this package, please let us know and we will
  reconsider before this version is published.

- `SystemRequirements` lists the Quarto command-line tool. It is needed only to
  render a workshop at runtime; the examples are wrapped in `\dontrun{}` and the
  vignettes do not call `drhur()`, so `R CMD check` does not require Quarto.

- The package links to `https://r-wasm.github.io/quarto-live/` (the Quarto Live
  project) in its documentation. The URL is valid; if the incoming-feasibility
  check flags it, that reflects transient network conditions rather than a
  broken link.

## Downstream dependencies

There are currently no downstream dependencies on CRAN.
