# building the vignette code

devtools::install(dependencies = TRUE, build_vignettes = TRUE)

# In between
# 1. Updating the NEWS.md 
# 1. Updating the DESCRIPTION if necessary

# release to cran

devtools::submit_cran() 
