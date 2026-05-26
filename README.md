# drhur <img src="https://user-images.githubusercontent.com/58319029/109610431-b5fc7080-7b67-11eb-9bfb-988bd1759c50.png" alt="drhur logo" width = "116.9" height = "135" align="right" />

------------------------------------------------------------------------

`drhur` is pedagogical software that makes R learners' lives a little easier and happier, and a supplementary courseware for Dr. Yue Hu's R lectures. The workshops were crystallized during Dr. Hu's online and offline R workshops.

As of version 2.0.0, each workshop is a self-contained [Quarto Live](https://r-wasm.github.io/quarto-live/) document: the code cells run directly in the browser via WebAssembly (`webR`), so learners read the instructions and run the exercises side by side **without setting up a local R session**.

## Installation

``` r
# Latest release from CRAN
install.packages("drhur")

# Development version
remotes::install_github("sammo3182/drhur")

# Or the WebAssembly-ready build from R-universe
install.packages("drhur", repos = "https://sammo3182.r-universe.dev")
```

Opening a workshop requires the [Quarto](https://quarto.org) command-line tool to be installed.

## Usage

``` r
library(drhur)

# Open a workshop as a scrollable HTML live document (the default)
drhur("algebra")

# ...or as a reveal.js slide deck
drhur("algebra", style = "slide")
```

The function renders the workshop and serves it on a local web server, then opens it in your browser. (Quarto Live cells rely on browser features that are disabled for files opened directly from disk, so the document is served over `http://localhost` rather than opened as a file.)

Available workshops (*Basics* series): `algebra`, `play`, `munging`, `descriptive`, `visual_basic`, and `loop`. Use `lang = "en"` for the English editions and `lang = "cn"` (the default) for the Chinese ones.

## More information

More details are available on the [package website](https://www.drhuyue.site/software/drhur/) and in the package vignette (`vignette("drhur-vignette")`).

Please note that this project is released with a [Contributor Code of Conduct](https://github.com/sammo3182/drhur/blob/master/CONDUCT.md). By participating in this project you agree to abide by its terms.
