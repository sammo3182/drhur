# Reinstall-and-review workflow for the Quarto Live workshops.
#
# WHY: `drhur()` serves each workshop from the *installed* package copy
# (`system.file("quarto_live", ...)`), NOT from this source tree. So an edit to
# `inst/quarto_live/*.qmd` is only visible through `drhur()` after the package is
# reinstalled. This script reinstalls, then opens the revised workshop so you can
# eyeball the change end to end.
#
# USAGE: set the three knobs below to the workshop you are revising, then source
# the whole file (Positron: Ctrl+Shift+S) or step through it section by section.

## 0. What to review ---------------------------------------------------------
# `workshop` is the file stem before `_live`: algebra, play, munging,
# descriptive, visual_basic, loop.

workshop <- "visual_basic"          # the workshop you edited
lang     <- "en"                    # "cn" (default edition) or "en"
style    <- "slide"              # "document" (live-html) or "slide" (live-revealjs)

## 1. Reinstall the package ---------------------------------------------------
# `quick = TRUE` skips docs/vignette rebuilds — fine here because we only changed
# a bundled .qmd, not R code. This copies the edited inst/quarto_live/ into the
# library so `drhur()` picks it up.

devtools::install(quick = TRUE, upgrade = "never", build_vignettes = FALSE)

## 2. Open the revised workshop -----------------------------------------------
# Loaded in a clean namespace so we run the just-installed version. In an
# interactive session `drhur()` serves the doc from a background server and opens
# the browser; the webR/OJS code cells run there.

pkgload::unload("drhur")            # drop any old copy from this session
library(drhur)

drhur(workshop, lang = lang, style = style)

# When done, stop the local preview server:
#   servr::daemon_stop()


## --- Faster loop for pure .qmd tweaks (no reinstall) ------------------------
# If you are only iterating on the .qmd text/cells, skip the reinstall entirely
# and live-preview the source file in place. Edit + save and the browser
# auto-refreshes. See inst/quarto_live/_preview.R for the why (cross-drive bug).
#
setwd(here::here("inst", "quarto_live"))
source("_preview.R")
preview(paste0(workshop, if (lang == "en") "_live_en" else "_live"),
        style = style)
