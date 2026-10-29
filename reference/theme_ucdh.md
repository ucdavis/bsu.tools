# UCDH ggplot2 theme

Applies UC Davis Health styling using colors from the UC Davis print
palette. Uses a combination of ggplot2's `theme_classic()`, `theme_bw()`
and customizations to apply UCDH colors to text, lines, and backgrounds.

## Usage

``` r
theme_ucdh(
  base_size = 11,
  base_family = "",
  ink = "black",
  paper = "white",
  grid_lines = TRUE
)
```

## Arguments

- base_size:

  Base font size in points.

- base_family:

  Base font family.

- ink:

  Color of text and lines.

- paper:

  Color of the background.

- grid_lines:

  Logical, whether to display grid lines.

## Value

A ggplot2 theme.

## References

[UC Davis Health Graphic Standards:
Colors](https://health.ucdavis.edu/graphic-standards/colors/) \# nolintr

## Examples

``` r
ggplot2::ggplot(
  iris,
  ggplot2::aes(Sepal.Length, Petal.Length, colour = Species)
) +
  ggplot2::geom_point() +
  scale_colour_ucdh() +
  theme_ucdh()
```
