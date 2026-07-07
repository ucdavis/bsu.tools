#### basic summaries utils ####
basic_summary_table <- function(data, vars = colnames(data), by_var = NULL) {
  # remove by_var from vars if it exists
  if (!is.null(by_var)) {
    vars <- base::setdiff(vars, by_var)
  }
  # create initial summary table
  tbl_summary <- data |>
    gtsummary::tbl_summary(
      by = if (is.null(by_var)) NULL else dplyr::all_of(by_var),
      include = dplyr::all_of(vars),
      type = dplyr::where(is.numeric) ~ "continuous",
      statistic = gtsummary::all_continuous() ~ c(
        "{mean} ({sd})<br>{median} [{p25}, {p75}]<br>{min}, {max}"
      )
    )

  # add overall if by_var is not NULL
  if (!is.null(by_var)) {
    tbl_summary <- tbl_summary |>
      gtsummary::add_overall()
  }

  return(tbl_summary)
}

basic_summary_figures <- function(data, vars = colnames(data), by_var = NULL) {
  # remove by_var from vars if it exists
  if (!is.null(by_var)) {
    vars <- base::setdiff(vars, by_var)
  }
  # store class to plot appropriate figure type
  var_class <- sapply(data[, vars], class)
  # if by_var is not NULL and is continuous, convert to factor
  if (
    !is.null(by_var) &&
    class(data[[by_var]]) %in% c("numeric", "integer", "double")
  ) {
    data <- data |>
      dplyr::mutate(
        !!{{ by_var }} := .data[[by_var]] |> as.factor()
      )
  }

  figs <- lapply(
    vars,
    function(x) {
      # if the variable is numeric, create a boxplot
      if (var_class[x] %in% c("numeric", "integer")) {
        plot_obj <- if (is.null(by_var)) {
          min_hist_bins <- 10
          hist_bins <- max(min_hist_bins, ceiling(sqrt(nrow(data))))
          data |>
            ggplot2::ggplot() +
            ggplot2::aes(x = .data[[x]]) +
            ggplot2::geom_histogram(bins = hist_bins)
        } else {
          data |>
            ggplot2::ggplot() +
            ggplot2::aes(x = .data[[by_var]], y = .data[[x]]) +
            ggplot2::geom_boxplot()
        }
      } else {
        # if the variable is categorical, create a bar plot
        plot_obj <- if (is.null(by_var)) {
          data |>
            ggplot2::ggplot() +
            ggplot2::aes(x = .data[[x]]) +
            ggplot2::geom_bar()
        } else {
          data |>
            ggplot2::ggplot() +
            ggplot2::aes(x = .data[[x]], fill = .data[[by_var]]) +
            ggplot2::geom_bar(position = "dodge")
        }
      }

      plot_obj + ggplot2::theme_classic()
    }
  )
  # add names to list
  names(figs) <- vars

  return(figs)
}
