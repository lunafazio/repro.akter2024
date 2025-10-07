#' Generate subfigures for Figure 2. 
#'
#' Running this function will generate eight PDF files in the current working
#' directory (check with `getwd()`).
#' 
#' @return Invisibly returns the path where the figures were saved.
#' @export
make_fig2 = function() {
  # Load data
  dfOR = suppressMessages(load_data("OR"))

  # Auxiliary data frame for "Quit any" outcome (combines all "Quit *" outcomes)
  dfAny = dfOR |>
  dplyr::filter(grepl("Quit ", Outcome)) |>
  dplyr::mutate(Outcome = "Quit any")

  # Prepare plotting inputs
  df_input = dplyr::bind_rows(dfOR,dfAny) |>
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
  dplyr::filter(n_studies > 1) |>
  tidyr::unnest(data) |>
  tidyr::nest(.by = c(Outcome)) |>
  dplyr::arrange(Outcome) |>
  dplyr::mutate(data = lapply(data, netmetaOR)) |>
  dplyr::mutate(rank = lapply(data, netmeta::netrank, small.values = "bad"))

  # Save plots
  capture.output( # suppress console output
    sapply(1:nrow(df_input), function(i) {
      path = \(x)paste0("fig2",letters[i],"_",x,".pdf")
      forestplot(df_input$data[[i]], path("forest"))
      pdf(path("rank"))
      print(rankplot(df_input$rank[[i]]))
      dev.off()
    })
  )
  message("Figures saved to: ", getwd())
  invisible(getwd())
}

#' Generate subfigures for Figure 3. 
#'
#' Running this function will generate four PDF files in the current working
#' directory (check with `getwd()`).
#' 
#' @return Invisibly returns the path where the figures were saved.
#' @export
make_fig3 = function() {
  df_input = suppressMessages(load_data("OR")) |>
  tidyr::nest(.by = c(Outcome,treat1)) |>
  dplyr::filter(Outcome %in% c("Smoking prevalence", "E-cigarettes use")) |>
  dplyr::mutate(
    Outcome = factor(
      Outcome,
      c("Smoking prevalence", "E-cigarettes use"),
      ordered = TRUE
    )
  ) |>
  # Study count based on unique study IDs
  dplyr::mutate(n_studies = sapply(data,\(x)length(unique(x$unid)))) |>
  dplyr::filter(n_studies > 1) |>
  tidyr::unnest(data) |>
  tidyr::nest(.by = c(Outcome)) |>
  dplyr::arrange(Outcome) |>
  dplyr::mutate(data = lapply(data, netmetaOR)) |>
  dplyr::mutate(rank = lapply(data, netmeta::netrank, small.values = "good"))

  # Save plots
  capture.output( # suppress console output
    sapply(1:nrow(df_input), function(i) {
      path = \(x)paste0("fig3",letters[i],"_",x,".pdf")
      forestplot(df_input$data[[i]], path("forest"))
      pdf(path("rank"))
      print(rankplot(df_input$rank[[i]]))
      dev.off()
    })
  )
  message("Figures saved to: ", getwd())
  invisible(getwd())
}
