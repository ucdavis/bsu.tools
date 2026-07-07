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
    # add Figure Column
    gtsummary::modify_table_body(
      ~ .x |>
        dplyr::mutate(
          Figures = dplyr::if_else(row_type == "label", variable, NA_character_)
        )
    ) |>
    gtsummary::modify_column_unhide(Figures) |>
    gtsummary::modify_header(Figures = "**Figure**") |>
    # convert to gt
    gtsummary::as_gt() |>
    # add figures to Figure column
    gt::text_transform(
      locations = gt::cells_body(columns = "Figures"),
      fn = function(x) {
        purrr::map(x, \(v) {
          if (is.na(v) || !v %in% names(figs)) {
            ""
          } else {
            gt::ggplot_image(figs[[v]])
          }
        })
      }
    ) |>
    gt::fmt_markdown(columns = dplyr::starts_with("stat_"))

  return(tbl_gt)
}
