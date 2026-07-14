# Standalone preview for the Quarto Live workshop files.
#
# WHY: The editor's "Preview" button renders a doc with `embed-resources: true`
# to a temp `--output-dir` on C:. Because this project lives on D:, Quarto glues
# the (relative-treated) output dir onto the input's path and produces the
# impossible cross-drive path `D:\...\quarto_live\C:\Users\...\Temp\...`
# (Windows "os error 123"). Previewing *in place* (no `--output-dir`) avoids it.
#
# USAGE (from this folder):
#   Rscript _preview.R algebra_live_en          # preview as a live-html document
#   Rscript _preview.R algebra_live_en slide    # preview as reveal.js slides
# or in an R console with the working dir set here:
#   source("_preview.R"); preview("algebra_live_en")
#
# Ctrl+C stops the server. Edit the .qmd and the browser refreshes on save.
# Rendered outputs (*.html, *_files/) are git- and Rbuild-ignored, so nothing
# generated here leaks into the package.

preview <- function(file, style = c("document", "slide"), port = 7654) {
  style <- match.arg(style)
  qmd <- if (grepl("\\.qmd$", file)) file else paste0(file, ".qmd")
  if (!file.exists(qmd)) stop("No such file: ", qmd, call. = FALSE)

  quarto_bin <- quarto::quarto_path()
  if (is.null(quarto_bin)) {
    stop("Quarto CLI not found. Install it from https://quarto.org", call. = FALSE)
  }

  format <- if (style == "slide") "live-revealjs" else "live-html"

  # Deliberately NO --output-dir: serving in place is what makes webR/OJS cells
  # work (browsers block them over file://) and sidesteps the cross-drive bug.
  system2(quarto_bin, c(
    "preview", shQuote(qmd),
    "--to", format,
    "--port", port
  ))
}

if (sys.nframe() == 0L) {
  args <- commandArgs(trailingOnly = TRUE)
  if (length(args) < 1L) stop("Give a workshop file, e.g. Rscript _preview.R algebra_live_en")
  style <- if (length(args) >= 2L) args[[2L]] else "document"
  preview(args[[1L]], style = style)
}
