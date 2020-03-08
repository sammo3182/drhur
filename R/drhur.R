#' Calling for an Exercise in Dr Hu's R Workshop
#'
#' The function calls a \code{\link[learnr]{run_tutorial}} function to open a \code{learnr} project. The project list is continually updated along with the R workshop with Dr. Hu.
#' @param workshop A character vector indicating the name of the workshop to open. See details for the workshop list.
#'
#' @details The list of workshop available so far:
#' \itemize{
#' \item Data munging (\code{munging}): Describe data, select columns, rows, and cells and so on.
#' \item Data analyzing (\code{analyzing}): Analyze data with descriptive and multivariate tools.
#' \item Data presenting (\code{presenting}): Present analytic results in tables and plots.
#' }
#'
#' @import learnr
#'
#' @export

drhur <-
  function(workshop) {
    learnr::run_tutorial(workshop, package = "drhur")
  }
