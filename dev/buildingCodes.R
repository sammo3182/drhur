# building the vignette code

# Sync the authoring copy of the Quarto Live workshops (dev/quarto_live, kept out
# of the build via .Rbuildignore) into inst/quarto_live, which is what `drhur()`
# renders from after the package is installed. Run this whenever the dev qmds or
# their assets (_extensions, _quarto.yml, theme/, .bib) change.
sync_quarto_live <- function() {
  src <- "dev/quarto_live"
  dest <- "inst/quarto_live"
  unlink(dest, recursive = TRUE, force = TRUE)
  dir.create(dest, recursive = TRUE, showWarnings = FALSE)
  file.copy(
    list.files(src, full.names = TRUE, all.files = TRUE, no.. = TRUE),
    dest, recursive = TRUE
  )
  # Drop build cruft that should not ship.
  unlink(file.path(dest, ".quarto"), recursive = TRUE, force = TRUE)
  unlink(list.files(dest, "\\.gitignore$", recursive = TRUE, full.names = TRUE), force = TRUE)
  invisible(dest)
}

sync_quarto_live()

devtools::install(dependencies = TRUE, build_vignettes = TRUE)

# In between
# 1. Update the NEWS.md 
# 1. Update the DESCRIPTION if necessary


# Release to cran
# 1. Delete the htmls

devtools::submit_cran() 
