test_that("basic_summaries returns S7 result with expected properties", {
  skip_if_not_installed("S7")
  skip_if_not_installed("gt")
  skip_if_not_installed("gtsummary")
  skip_if_not_installed("ggplot2")

  result <- basic_summaries(
    data = iris,
    vars = c("Sepal.Length", "Petal.Length"),
    by_var = "Species"
  )

  expect_s3_class(result, "basic_summaries_result")
  expect_s3_class(S7::prop(result, "tbl_gt"), "gt_tbl")
  expect_s3_class(S7::prop(result, "raw_table"), "gtsummary")

  figures <- S7::prop(result, "figures")
  expect_type(figures, "list")
  expect_setequal(names(figures), c("Sepal.Length", "Petal.Length"))
  expect_true(all(vapply(figures, inherits, logical(1), what = "ggplot")))
})

test_that("basic_summaries works without by_var", {
  skip_if_not_installed("S7")
  skip_if_not_installed("gt")
  skip_if_not_installed("gtsummary")
  skip_if_not_installed("ggplot2")

  result <- basic_summaries(
    data = iris,
    vars = c("Sepal.Length", "Species")
  )

  figures <- S7::prop(result, "figures")
  expect_setequal(names(figures), c("Sepal.Length", "Species"))
  expect_true(all(vapply(figures, inherits, logical(1), what = "ggplot")))
})
