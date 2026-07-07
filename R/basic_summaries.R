#' @title Create Basic Summary Tables and Figures
#' @description
#' Creates a summary table using `gtsummary::tbl_summary()`, generates
#' variable-level figures, and returns an S7 object containing the gt table,
#' raw gtsummary table, and figures.
#' @param data A data frame.
#' @param vars Character vector of variable names to summarize. Defaults to all
#' columns in `data`.
#' @param by_var Optional grouping variable name.
#' @returns A `basic_summaries_result` object with properties:
#' \itemize{
#'   \item `tbl_gt`: gt table with embedded figures
#'   \item `raw_table`: underlying gtsummary table
#'   \item `figures`: named list of ggplot objects
#' }
#' @export
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
    gtsummary::modify_column_unhide("Figures") |>
    gtsummary::modify_header(Figures = "**Figures**") |>
    # convert to gt (set id for testing)
    gtsummary::as_gt(id = "gt_tbl") |>
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

  new_basic_summaries_result(
    tbl_gt = tbl_gt,
    raw_table = tbl,
    figures = figs
  )
}
