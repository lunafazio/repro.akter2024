#' Wrapper for the meta-analysis function called on OR measures.
#'
#' Argument names changed according to newer version of `meta` package.
#' Results are unchanged.
#' 
#' @param data A tibble with OR data (see `load_data`).
#' @return A `meta` object.
metaOR = function(data) {
  meta::metagen(
    TE = TE, seTE = seTE,
    data = data,
    studlab = study,
    sm = "OR",
    common = TRUE, random = TRUE,
    method.tau = "REML",
    method.random.ci = TRUE
  )
}

#' Wrapper for the meta-analysis function called on MD measures.
#'
#' Argument names changed according to newer version of `meta` package.
#' Results are unchanged.
#' 
#' @param data A tibble with MD data (see `load_data`).
#' @return A `meta` object.
metaMD = function(data) {
  meta::metagen(
    TE = ES, seTE = SE,
    data = data,
    studlab = study,
    sm = "MD",
    common = TRUE, random = TRUE,
    method.tau = "REML",
    method.random.ci = TRUE
  )
}