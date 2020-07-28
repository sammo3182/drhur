#' Calling for an Exercise in Dr Hu's R Workshop
#'
#' The function calls a \code{\link[learnr]{run_tutorial}} function to open a \code{learnr} project. The project list is continually updated along with the R workshop with Dr. Hu.
#' @param workshop A character vector indicating the name of the workshop to open. See details for the workshop list.
#'
#' @details The list of workshop available so far:
#' \itemize{
#' \item Playing around with R (\code{playing}): Intro to basic data structure in R; inputting, outputting, and creating data.
#' \item Data munging (\code{munging}): Generalizing (such as sorting and summarizing) and extracting (selecting or adjusting certain columns or rows) data frames.
#' \item Data analyzing (\code{analyzing}): Analyze data with descriptive and multivariate tools and diagnoses.
#' \item Data presenting (\code{visualizing}): Present descriptive and analytic results with `ggplot2`
#' }
#'
#' @import learnr
#'
#' @export

drhur <-
  function(workshop) {
    learnr::run_tutorial(workshop, package = "drhur")
  }
