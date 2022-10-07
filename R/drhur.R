#' Calling for an Exercise in Dr Hu's R Workshop
#'
#' The function calls a \code{\link[learnr]{run_tutorial}} function to open a \code{learnr} project. The project list is continually updated along with the R workshop with Dr. Hu.
#' 
#' @param workshop A character vector indicating the name of the workshop to open. See details for the workshop list.
#' @param language A character vector indicating the display language. The current version includes workshops in English (\code{en}) and simple Chinese (\code{cn}). The default is Chinese.
#'
#' @details The list of workshop available for the current version:
#' \itemize{
#' \item \code{calculate}: Basic syntax of R (Chinese).
#' \item \code{play}: Basic data structure in R; inputting, outputting, and creating data.
#' \item \code{wrangle}: Generalizing (such as sorting and summarizing) and extracting (selecting or adjusting certain columns or rows) data frames (English and Chinese).
#' \item \code{describe}: Skills to describe variable and data.
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
