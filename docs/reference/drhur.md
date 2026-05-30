# Calling for a Workshop in Dr Hu's R Workshop

The function renders a self-contained [Quarto
Live](https://r-wasm.github.io/quarto-live/) document from the workshop
materials shipped with the package and opens it in the browser. Each
workshop is an interactive document whose code cells run in the browser
via WebAssembly (`webR`); no local R session is required to run the
exercises. The workshop list is continually updated along with the R
workshop with Dr. Hu.

## Usage

``` r
drhur(
  workshop,
  lang = "cn",
  style = "document",
  output_dir = tempdir(),
  quiet = FALSE
)
```

## Arguments

- workshop:

  A character string naming the workshop to open. See details for the
  available workshops.

- lang:

  A character string giving the display language: simplified Chinese
  (`"cn"`, the default) or English (`"en"`).

- style:

  A character string choosing the output style: `"document"` (the
  default) renders a scrollable Quarto Live HTML document (`live-html`);
  `"slide"` renders a reveal.js slide deck (`live-revealjs`).

- output_dir:

  Directory in which the workshop is rendered. Defaults to a per-session
  temporary directory. The installed package files are never modified.

- quiet:

  Logical; suppress Quarto's rendering output. Defaults to `FALSE`.

## Value

(Invisibly) the path to the rendered HTML file.

## Details

The workshops available in the current version (*Basics* series):

- `algebra`: Basic maths, vectors, and matrices with R syntax.

- `play`: Basic data structures; inputting, outputting, and creating
  data.

- `munging`: Generalizing and extracting data frames (sorting,
  summarizing, selecting, mutating).

- `descriptive`: Describing variables and data, including summary tables
  and distribution plots.

- `visual_basic`: Presenting variables, patterns, and estimates with
  visualization tools.

- `loop`: Conditionals, loops, and batch processing.

Every workshop ships in two language editions, selected with `lang`:
simplified Chinese (`"cn"`, the default) and English (`"en"`).

Rendering requires the [Quarto](https://quarto.org) command-line tool to
be installed. Running the interactive code cells in the rendered
document additionally requires an internet connection, because the
`webR` runtime and the workshop's R packages are downloaded in the
browser at view time.

Because Quarto Live cells run on OJS and `webR`, which browsers disable
for documents opened directly from disk (`file://`), the workshop is
served over a local web server rather than opened as a file. This
serving step uses the servr package, a suggested dependency; install it
with `install.packages("servr")` if prompted. In an interactive session
the server is started in the background (so your R console stays free)
and remains available for the rest of the session; stop it with
[`servr::daemon_stop()`](https://rdrr.io/pkg/servr/man/daemon_stop.html).

## Examples

``` r
if (FALSE) { # \dontrun{
# Open the algebra workshop as an HTML live document (Chinese, the default)
drhur("algebra")

# Open the same workshop in English
drhur("algebra", lang = "en")

# Open the data-munging workshop as a slide deck
drhur("munging", style = "slide")
} # }
```
