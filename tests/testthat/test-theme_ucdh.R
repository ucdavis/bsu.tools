test_that("theme_ucdh applies UCDH styling without changing axis colors", {
  theme <- theme_ucdh()
  default_theme <- ggplot2::theme_minimal()

  expect_s3_class(theme, "theme")
  expect_identical(theme$title$colour, "#002855")
  expect_identical(
    ggplot2::calc_element("axis.text.x", theme)$colour,
    ggplot2::calc_element("axis.text.x", default_theme)$colour
  )
  expect_identical(
    ggplot2::calc_element("axis.title.x", theme)$colour,
    ggplot2::calc_element("axis.title.x", default_theme)$colour
  )
  expect_identical(theme$axis.line, default_theme$axis.line)
  expect_identical(theme$panel.grid.major$colour, "#B1B3B3")
  expect_identical(theme$strip.background$fill, "#002855")
})

test_that("theme_ucdh supports custom base text settings", {
  theme <- theme_ucdh(base_size = 14, base_family = "serif")

  expect_identical(theme$text$size, 14)
  expect_identical(theme$text$family, "serif")
})

test_that("UCDH discrete scales use the bright print palette", {
  expected <- c(
    "#002855", "#ED8B00", "#00B5E2", "#C6007E",
    "#78BE20", "#642667", "#BA0C2F", "#008EAA"
  )

  expect_identical(scale_colour_ucdh()$palette(8), expected)
  expect_identical(scale_color_ucdh()$palette(8), expected)
  expect_identical(scale_fill_ucdh()$palette(8), expected)
})

test_that("UCDH theme and scales can be added to a plot", {
  plot <- ggplot2::ggplot(
    iris,
    ggplot2::aes(Sepal.Length, Petal.Length, colour = Species)
  ) +
    ggplot2::geom_point() +
    scale_colour_ucdh() +
    theme_ucdh()

  expect_s3_class(plot, "ggplot")
  expect_s3_class(plot$scales$get_scales("colour"), "ScaleDiscrete")
})
