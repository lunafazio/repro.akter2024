#' Wrapper for the meta-analysis function called on OR measures.
#'
#' Used for pairwise meta-analysis in Tables 2 and 3.
#' 
#' Argument names changed according to newer version of `meta` package.
#' Results are unchanged.
#' 
#' @param data A tibble with OR data (see `load_data`).
#' @return A `meta` object.
#' @export
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
#' Used for pairwise meta-analysis in Table 4.
#' 
#' Argument names changed according to newer version of `meta` package.
#' Results are unchanged.
#' 
#' @param data A tibble with MD data (see `load_data`).
#' @return A `meta` object.
#' @export
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