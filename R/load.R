#' Load the study's data.
#'
#' @param measure Must exactly match "OR" or "MD".
#' @return A tibble with data for the specified measure.
#' @export
load_data = function(measure=NULL) {
  stopifnot("Argument must equal \"OR\" or \"MD\"" =
    identical(measure,"OR")|identical(measure,"MD"))
  if(measure == "OR") file = system.file("extdata",
    "data 1_repository.xls", package="repro.akter2024")
  if(measure == "MD") file = system.file("extdata",
    "data 2_repository.xls", package="repro.akter2024")
  cat("Loaded from ", file, "\n")
  return(readxl::read_xls(file))
}