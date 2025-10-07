#' Produce rank plot from netrank object.
#'
#' Code taken directly from Akter et al. Used in Figures 2 and 3.
#' 
#' @param data A netrank object
#' @export
rankplot = function(data) {
  plot(data,
    low = "red", mid = "yellow", high = "green", col = "black",
    name ="",
    main.col = col,
    legend = TRUE,
    axis.size = 12,
    digits = 2)
}

#' Produce forest plot from netmeta object. 
#'
#' Code taken directly from Akter et al. Used in Figures 2 and 3.
#' Output is saved directly to a PDF file.
#' 
#' @param data A netmeta object
#' @param file Filepath where the plot will be saved
#' @export
forestplot = function(data, file) {
  metafor::forest(data, file = file,
    reference.group = "Control", 
    digits=2, 
    drop.reference.group = TRUE,
    axis.size = 14,
    label.left ="Favors Control", 
    label.right ="Favors Policy",
    clip = c(0.5, 1, 1.5,2.0, 2.5), 
    xlog = TRUE,
    smlab = paste("","Random Effects Model"),
    rightcols = c("effect", "ci"),
    just.addcols = "right",
    sortvar = -Pscore,
    drop = TRUE, 
    lineheight = "auto",
    col = forestplot::fpColors(box = "royalblue", 
    line = "darkblue"))
}
