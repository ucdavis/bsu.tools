basic_summaries <- function(data, vars = colnames(data), by_var = NULL) {
  # create summary table using gtsummary::tbl_summary()
  tbl <- basic_summary_table(
    data = data,
    vars = vars,
    by_var = by_var
  )
  # create summary figures (histogram for numeric, bar plot for categorical)
  figs <- basic_summary_figures(
    data = data,
    vars = vars,
    by_var = by_var
  )
  # convert tbl to gt object and add figures
  tbl_gt <- tbl |>
    gtsummary::as_gt() |>
    gt::cols_add(
      Figures = NA
    ) |>
    gt::text_transform(
      locations = gt::cells_body(columns = "Figures"),
      fn = function(x) {
        figs |> gt::ggplot_image()
      }
    ) |>
    gt::fmt_markdown(columns = dplyr::starts_with("stat_"))

  return(tbl_gt)
}
