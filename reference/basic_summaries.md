# Create Basic Summary Tables and Figures

Creates a summary table using
[`gtsummary::tbl_summary()`](https://www.danieldsjoberg.com/gtsummary/reference/tbl_summary.html),
generates variable-level figures, and returns an S7 object containing
the gt table, raw gtsummary table, and figures.

## Usage

``` r
basic_summaries(data, vars = colnames(data), by_var = NULL)

# S3 method for class 'basic_summaries_result'
print(x, ...)
```

## Arguments

- data:

  A data frame.

- vars:

  Character vector of variable names to summarize. Defaults to all
  columns in `data`.

- by_var:

  Optional grouping variable name.

- x:

  A `basic_summaries_result` object.

- ...:

  Additional arguments passed to
  [`print()`](https://rdrr.io/r/base/print.html).

## Value

A `basic_summaries_result` object with properties:

- `tbl_gt`: gt table with embedded figures

- `raw_table`: underlying gtsummary table

- `figures`: named list of ggplot objects
