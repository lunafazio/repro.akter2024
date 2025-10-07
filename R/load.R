#' Load the study's data.
#'
#' When called, the function prints the local path where the source `xls` file
#' resides.
#' 
#' @param measure Must exactly match "OR" or "MD".
#' @return A tibble with data for the specified measure.
#' @references
#' Akter, S., Rahman, M.M., Rouyard, T. et al. A systematic review and network
#' meta-analysis of population-level interventions to tackle smoking behaviour.
#' Nat Hum Behav 8, 2367–2391 (2024). <https://doi.org/10.1038/s41562-024-02002-7>
#' @export
load_data = function(measure=NULL) {
  stopifnot("Argument must equal \"OR\" or \"MD\"" =
    identical(measure,"OR")|identical(measure,"MD"))
  if(measure == "OR") file = system.file("extdata",
    "data 1_repository.xls", package="repro.akter2024")
  if(measure == "MD") file = system.file("extdata",
    "data 2_repository.xls", package="repro.akter2024")
  message("Loaded from ", file)
  return(readxl::read_xls(file))
}
