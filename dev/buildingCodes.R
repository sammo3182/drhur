# building the vignette code

devtools::install(dependencies = TRUE, build_vignettes = TRUE)

# In between
# 1. Update the NEWS.md 
# 1. Update the DESCRIPTION if necessary


# Release to cran
# 1. Delete the htmls

devtools::submit_cran() 
