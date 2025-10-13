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
  suppressWarnings(meta::metagen(
    TE = TE, seTE = seTE,
    data = data,
    studlab = study,
    sm = "OR",
    fixed = TRUE, random = TRUE,
    method.tau = "REML",
    hakn = TRUE))
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
  suppressWarnings(meta::metagen(
    TE = ES, seTE = SE,
    data = data,
    studlab = study,
    sm = "MD",
    fixed = TRUE, random = TRUE,
    method.tau = "REML",
    hakn = TRUE))
}

#' Wrapper for the network meta-analysis function.
#'
#' Used for network meta-analysis in Figures 2 and 3.
#' 
#' Argument names changed according to newer version of `netmeta` package.
#' Results are unchanged.
#' 
#' @param data A tibble with OR data (see `load_data`).
#' @return A `netmeta` object.
#' @export
netmetaOR = function(data) {
  netmeta::netmeta(
    TE = TE, seTE = seTE,
    treat1 = treat1,  # Policy
    treat2 = treat2,  # Control 
    studlab = studyid, data = data,
    sm = "OR",
    common = FALSE, random = TRUE,
    reference.group = "Control",
    details.chkmultiarm = TRUE,
    sep.trts = " vs ")
}
