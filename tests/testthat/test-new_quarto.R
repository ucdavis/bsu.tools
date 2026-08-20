test_that("new_quarto errors when filename is NULL and no explorer available", {
  # In a non-interactive session the file explorer cannot be shown, so the
  # function should fall back to erroring rather than silently continuing.
  expect_error(
    new_quarto(filename = NULL, path = tempdir()),
    "Invalid filename"
  )
})

test_that("choose_quarto_file errors in non-interactive sessions", {
  expect_error(
    bsu.tools:::choose_quarto_file(tempdir()),
    "Invalid filename"
  )
})

test_that("new_quarto uses the file chosen by the explorer pop-up", {
  dir <- withr::local_tempdir()
  chosen <- file.path(dir, "my_report")

  # Pretend the interactive file explorer returned a chosen path.
  local_mocked_bindings(
    choose_quarto_file = function(path) chosen
  )

  new_quarto(filename = NULL, path = dir, gist = "no_logo_quarto")

  expect_true(file.exists(file.path(dir, "my_report.qmd")))
  # The shared stylesheet is copied alongside the document so the template's
  # `css: template_css.css` reference resolves at render time.
  expect_true(file.exists(file.path(dir, "template_css.css")))
})
