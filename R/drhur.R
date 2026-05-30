#' Calling for a Workshop in Dr Hu's R Workshop
#'
#' The function renders a self-contained \href{https://r-wasm.github.io/quarto-live/}{Quarto Live}
#' document from the workshop materials shipped with the package and opens it in
#' the browser. Each workshop is an interactive document whose code cells run in
#' the browser via WebAssembly (\code{webR}); no local R session is required to
#' run the exercises. The workshop list is continually updated along with the R
#' workshop with Dr. Hu.
#'
#' @param workshop A character string naming the workshop to open. See details
#'   for the available workshops.
#' @param lang A character string giving the display language: simplified
#'   Chinese (\code{"cn"}, the default) or English (\code{"en"}).
#' @param style A character string choosing the output style: \code{"document"}
#'   (the default) renders a scrollable Quarto Live HTML document
#'   (\code{live-html}); \code{"slide"} renders a reveal.js slide deck
#'   (\code{live-revealjs}).
#' @param output_dir Directory in which the workshop is rendered. Defaults to a
#'   per-session temporary directory. The installed package files are never
#'   modified.
#' @param quiet Logical; suppress Quarto's rendering output. Defaults to
#'   \code{FALSE}.
#'
#' @details The workshops available in the current version (\emph{Basics}
#'   series):
#' \itemize{
#' \item \code{algebra}: Basic maths, vectors, and matrices with R syntax.
#' \item \code{play}: Basic data structures; inputting, outputting, and creating data.
#' \item \code{munging}: Generalizing and extracting data frames (sorting, summarizing, selecting, mutating).
#' \item \code{descriptive}: Describing variables and data, including summary tables and distribution plots.
#' \item \code{visual_basic}: Presenting variables, patterns, and estimates with visualization tools.
#' \item \code{loop}: Conditionals, loops, and batch processing.
#' }
#'
#' Every workshop ships in two language editions, selected with \code{lang}:
#' simplified Chinese (\code{"cn"}, the default) and English (\code{"en"}).
#'
#' Rendering requires the \href{https://quarto.org}{Quarto} command-line tool to
#' be installed. Running the interactive code cells in the rendered document
#' additionally requires an internet connection, because the \code{webR} runtime
#' and the workshop's R packages are downloaded in the browser at view time.
#'
#' Because Quarto Live cells run on OJS and \code{webR}, which browsers disable
#' for documents opened directly from disk (\code{file://}), the workshop is
#' served over a local web server rather than opened as a file. This serving
#' step uses the \pkg{servr} package, a suggested dependency; install it with
#' \code{install.packages("servr")} if prompted. In an interactive session the
#' server is started in the background (so your R console stays free) and
#' remains available for the rest of the session; stop it with
#' \code{servr::daemon_stop()}.
#'
#' @return (Invisibly) the path to the rendered HTML file.
#'
#' @examples
#' \dontrun{
#' # Open the algebra workshop as an HTML live document (Chinese, the default)
#' drhur("algebra")
#'
#' # Open the same workshop in English
#' drhur("algebra", lang = "en")
#'
#' # Open the data-munging workshop as a slide deck
#' drhur("munging", style = "slide")
#' }
#'
#' @importFrom quarto quarto_render quarto_path
#'
#' @export
drhur <- function(workshop,
                  lang = "cn",
                  style = "document",
                  output_dir = tempdir(),
                  quiet = FALSE) {
  lang <- match.arg(lang, c("cn", "en"))
  style <- match.arg(style, c("document", "slide"))

  if (missing(workshop) || !is.character(workshop) || length(workshop) != 1L) {
    stop("`workshop` must be a single workshop name. See `?drhur` for the list.",
         call. = FALSE)
  }

  # Quarto command-line tool is required to render.
  if (is.null(quarto::quarto_path())) {
    stop("The Quarto command-line tool was not found.\n",
         "Install it from https://quarto.org and try again.",
         call. = FALSE)
  }

  src_dir <- system.file("quarto_live", package = "drhur")
  if (!nzchar(src_dir)) {
    stop("Could not locate the bundled 'quarto_live' materials in the drhur package.",
         call. = FALSE)
  }

  suffix <- if (lang == "cn") "_live" else "_live_en"
  qmd_name <- paste0(workshop, suffix, ".qmd")
  qmd_path <- file.path(src_dir, qmd_name)

  if (!file.exists(qmd_path)) {
    available <- list.files(src_dir, pattern = "_live(_en)?\\.qmd$")
    available <- sort(unique(sub("_live(_en)?\\.qmd$", "", available)))
    stop(sprintf(
      "Workshop '%s' (lang = '%s') is not available.\nAvailable workshops: %s",
      workshop, lang, paste(available, collapse = ", ")),
      call. = FALSE)
  }

  # Render in a writable copy: the installed package directory is read-only,
  # and Quarto writes its output next to the input file.
  work_dir <- file.path(output_dir, paste0("drhur_", workshop, "_", lang))
  unlink(work_dir, recursive = TRUE, force = TRUE)
  dir.create(work_dir, recursive = TRUE, showWarnings = FALSE)
  file.copy(
    from = list.files(src_dir, full.names = TRUE, all.files = TRUE, no.. = TRUE),
    to = work_dir,
    recursive = TRUE
  )

  format <- if (style == "slide") "live-revealjs" else "live-html"
  quarto::quarto_render(
    input = file.path(work_dir, qmd_name),
    output_format = format,
    quiet = quiet
  )

  out_name <- paste0(workshop, suffix, ".html")
  out_html <- file.path(work_dir, out_name)
  if (!file.exists(out_html)) {
    stop("Rendering finished but the expected HTML output was not found:\n",
         out_html, call. = FALSE)
  }

  # Quarto Live cells run on OJS + webR, which browsers disable over file://
  # URLs. The document must therefore be served over http; we start a local
  # static web server rooted at the rendered directory and open that URL.
  # In interactive sessions the server is daemonized (non-blocking) and stays
  # up for the rest of the session; stop it with `servr::daemon_stop()`.
  # 'servr' is only needed to view a workshop, so it is a soft (Suggests)
  # dependency loaded on demand rather than at install time.
  if (!requireNamespace("servr", quietly = TRUE)) {
    stop("Opening a workshop needs the 'servr' package to serve it locally.\n",
         "Install it with install.packages(\"servr\"), then try again.",
         call. = FALSE)
  }
  servr::httd(
    dir = work_dir,
    initpath = out_name,
    daemon = interactive(),
    browser = TRUE,
    verbose = !quiet
  )

  invisible(out_html)
}
