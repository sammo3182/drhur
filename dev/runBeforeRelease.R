# Check List for A New Release
# Run each section sequentially; individual lines can be sourced as needed.

## 0. After Any Function or Documentation Changes ----------------------------
# (Daily use during development)

devtools::document()  # Regenerate NAMESPACE and man/ from roxygen2 comments
devtools::load_all()  # Reload package in session without reinstalling

## 1. Vignette Building -------------------------------------------------------

devtools::build_vignettes()               # Build and preview vignettes locally

# For final verification before submission:
devtools::install(build_vignettes = TRUE)

## 2. Spell Check --------------------------------------------------------------

devtools::spell_check()

## 3. Pre-submission Checks ---------------------------------------------------

# Local R CMD check (automatically calls document() internally)
devtools::check()

# Cross-platform check via GitHub Actions (rhub v2)
# One-time setup — skip if .github/workflows/rhub.yaml already exists:
#   rhub::rhub_setup()
# Commit and push all changes to GitHub, then run:
rhub::rhub_check()

## 4. Pre-submission Housekeeping ---------------------------------------------

# Remove compiled HTML vignettes to reduce tarball size
ls_html <- list.files(
  here::here("vignettes"),
  pattern    = "\\.html$",
  recursive  = TRUE,
  full.names = TRUE
)
file.remove(ls_html)

# Manual checklist:
# [ ] Update version number in DESCRIPTION (remove .9999 suffix)
# [ ] Update NEWS.md
# [ ] Update cran-comments.md

## 5. Submit to CRAN ----------------------------------------------------------
# release() runs a final series of checks before opening the CRAN web form

devtools::release()

# After CRAN acceptance: bump version back to x.y.z.9999 in DESCRIPTION
# Post the release note when the package appears on CRAN

## 6. Post-release (run once; skip if already configured) --------------------

pkgdown::build_site()

# One-time project setup (already done for this package):
# usethis::git_vaccinate()
# usethis::use_github_links()
# usethis::use_github_action_check_standard()
