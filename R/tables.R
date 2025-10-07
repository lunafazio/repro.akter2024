#' Produce output for Table 2.
#' 
#' All measures in the OR dataset are used in the calculation. This includes
#' multiple measures from the same study, as this was found to give the closest
#' match to the original results.
#' 
#' Number of studies is separately calculated based on the unique study IDs.
#' Row order adjusted manually to match original table.
#' 
#' @return A tibble with the results of pairwise meta-analysis for
#' smoke cessation outcomes
#' @export
make_table2 = function() {
  # Load data
  dfOR = suppressMessages(load_data("OR"))

  # Auxiliary data frame for "Quit any" outcome (combines all "Quit *" outcomes)
  dfAny = dfOR |>
  dplyr::filter(grepl("Quit ", Outcome)) |>
  dplyr::mutate(Outcome = "Quit any")

  # Produce table
  dplyr::bind_rows(dfOR,dfAny) |>
  tidyr::nest(.by = c(Outcome,treat1)) |>
  dplyr::filter(grepl("Quit ", Outcome)) |>
  dplyr::mutate(
    Outcome = factor(
      Outcome,
      c("Quit intention", "Quit attempt", "Quit rate", "Quit any"),
      ordered = TRUE
    )
  ) |>
  # Study count based on unique study IDs
  dplyr::mutate(n_studies = sapply(data,\(x)length(unique(x$unid)))) |>
  # metaOR defined in R/meta.R
  dplyr::mutate(data = lapply(data, metaOR)) |>
  dplyr::arrange(Outcome, -n_studies) |>
  dplyr::mutate(
    OR = sapply(data, function(x)round(exp(x$TE.random),2)),
    ORl = sapply(data, function(x)round(exp(x$lower.random),2)),
    ORu = sapply(data, function(x)round(exp(x$upper.random),2)),
    pval = sapply(data, function(x)round(x$pval.random,4)),
    I2 = sapply(data, function(x)round(100*x$I2,1)),
    I2l = sapply(data, function(x)round(100*x$lower.I2,1)),
    I2u = sapply(data, function(x)round(100*x$upper.I2,1)),
    tau2 = sapply(data, function(x)round(x$tau2,2)),
    tau2l = sapply(data, function(x)round(x$lower.tau2,2)),
    tau2u = sapply(data, function(x)round(x$upper.tau2))
  ) |>
  dplyr::select(-data) |>
  dplyr::rename(outcome = Outcome, policy = treat1) |>
  # Manual reordering to better match original table
  dplyr::slice(c(1:11,13,12,14:18,21,19,20,25,24,26,23,22,
    27:30,35,32,34,31,33,37,39,38,36))
}

#' Produce output for Table 3.
#' 
#' All measures in the OR dataset are used in the calculation. This includes
#' multiple measures from the same study, as this was found to give the closest
#' match to the original results.
#' 
#' Smoking prevalence contains additional row not present in original table.
#' Number of studies is separately calculated based on the unique study IDs.
#' Row order adjusted manually to match original table.
#' 
#' @return A tibble with the results of pairwise meta-analysis for
#' smoking prevalence and e-cigarette use outcomes
#' @export
make_table3 = function() {
  t3_outcomes = c(
    "Smoking prevalence",
    "Secondhand smoke exposure",
    "E-cigarettes use"
  )
  suppressMessages(load_data("OR")) |>
  tidyr::nest(.by = c(Outcome,treat1)) |>
  dplyr::filter(Outcome %in% t3_outcomes) |>
  dplyr::mutate(Outcome = factor(Outcome, t3_outcomes, ordered = TRUE)) |>
  # Study count based on unique study IDs
  dplyr::mutate(n_studies = sapply(data,\(x)length(unique(x$unid)))) |>
  # metaOR defined in R/meta.R
  dplyr::mutate(data = lapply(data, metaOR)) |>
  dplyr::arrange(Outcome, -n_studies) |>
  dplyr::mutate(
    OR = sapply(data, function(x)round(exp(x$TE.random),2)),
    ORl = sapply(data, function(x)round(exp(x$lower.random),2)),
    ORu = sapply(data, function(x)round(exp(x$upper.random),2)),
    pval = sapply(data, function(x)round(x$pval.random,4)),
    I2 = sapply(data, function(x)round(100*x$I2,1)),
    I2l = sapply(data, function(x)round(100*x$lower.I2,1)),
    I2u = sapply(data, function(x)round(100*x$upper.I2,1)),
    tau2 = sapply(data, function(x)round(x$tau2,2)),
    tau2l = sapply(data, function(x)round(x$lower.tau2,2)),
    tau2u = sapply(data, function(x)round(x$upper.tau2))
  ) |>
  dplyr::select(-data) |>
  dplyr::rename(outcome = Outcome, policy = treat1) |>
  # Manual reordering to better match original table
  dplyr::slice(c(1:5,8,7,9,12,11,10,6,14,13,15,17,16,19,18,22,23,20,21))
}

#' Produce output for Table 4.
#' 
#' All measures in the OR dataset are used in the calculation. This includes
#' multiple measures from the same study, as this was found to give the closest
#' match to the original results.
#' 
#' Cigarette consumption contains additional row not present in original table.
#' Number of studies is separately calculated based on the unique study IDs.
#' Row order adjusted manually to match original table.
#' 
#' @return A tibble with the results of pairwise meta-analysis for
#' smoking consumption outcomes
#' @export
make_table4 = function() {
  t4_outcomes = c(
    "Cigarette consumption",
    "E-cig consumption",
    "Tobacco sales",
    "E-cigarette sale",
    "Quit attempt/rate",
    "Smoking prevalence"
  )
  suppressMessages(load_data("MD")) |>
  dplyr::mutate(Outcome =
    ifelse(grepl("Quit ", Outcome), "Quit attempt/rate", Outcome)) |>
  tidyr::nest(.by = c(Outcome,treat1)) |>
  dplyr::filter(Outcome %in% t4_outcomes) |>
  dplyr::mutate(Outcome = factor(Outcome, t4_outcomes, ordered = TRUE)) |>
  # Study count based on unique study IDs
  dplyr::mutate(n_studies = sapply(data,\(x)length(unique(x$unid)))) |>
  # metaMD defined in R/meta.R
  dplyr::mutate(data = lapply(data, metaMD)) |>
  dplyr::arrange(Outcome, -n_studies) |>
  dplyr::mutate(
    MD = sapply(data, function(x)round(x$TE.random,2)),
    MDl = sapply(data, function(x)round(x$lower.random,2)),
    MDu = sapply(data, function(x)round(x$upper.random,2)),
    pval = sapply(data, function(x)round(x$pval.random,4)),
    I2 = sapply(data, function(x)round(100*x$I2,1)),
    I2l = sapply(data, function(x)round(100*x$lower.I2,1)),
    I2u = sapply(data, function(x)round(100*x$upper.I2,1)),
    tau2 = sapply(data, function(x)round(x$tau2,2)),
    tau2l = sapply(data, function(x)round(x$lower.tau2,2)),
    tau2u = sapply(data, function(x)round(x$upper.tau2))
  ) |>
  dplyr::select(-data) |>
  dplyr::rename(outcome = Outcome, policy = treat1) |>
  # Manual reordering to better match original table
  dplyr::slice(c(1:3,5,4,7,6,11,10,8,9,12,14,13,15,18,17,16,19,20,22,23,21,
    25,24,32,26,29,28,31,30,27,36,34,35,33))
}