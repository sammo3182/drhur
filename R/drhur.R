#' Calling for an Exercise in Dr Hu's R Workshop
#'
#' The function calls a \code{\link[learnr]{run_tutorial}} function to open a \code{learnr} project. The project list is continually updated along with the R workshop with Dr. Hu.
#' @param workshop A character vector indicating the name of the workshop to open. See details for the workshop list.
#' @param language A character vector indicating the display language. The current version includes workshops in English (\code(en)) and simple Chinese (\code(cn)). The default is Chinese
#'
#' @details The list of workshop available for the current version:
#' \itemize{
#' \item \code{playing}: Intro to basic data structure in R; inputting, outputting, and creating data (English and Chinese).
#' \item \code{munging}: Generalizing (such as sorting and summarizing) and extracting (selecting or adjusting certain columns or rows) data frames (English and Chinese).
#' \item \code{analyzing}: Analyze data with descriptive and multivariate tools and diagnoses (English and Chinese).
#' \item Data presenting (\code{visualizing}): Present descriptive and analytic results with `ggplot2` (English and Chinese).
#' }
#'
#' @import learnr
#'
#' @export

drhur <-
  function(workshop, language = "cn") {
    if(language == "cn") workshop <- paste0(workshop, "_cn")
    learnr::run_tutorial(workshop, package = "drhur")
  }
