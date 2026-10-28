# UCDH discrete scales

Applies colors from the bright UC Davis print palette to discrete colour
or fill aesthetics.

## Usage

``` r
scale_colour_ucdh(...)

scale_color_ucdh(...)

scale_fill_ucdh(...)
```

## Arguments

- ...:

  Arguments passed to
  [`ggplot2::scale_colour_manual()`](https://ggplot2.tidyverse.org/reference/scale_manual.html)
  or
  [`ggplot2::scale_fill_manual()`](https://ggplot2.tidyverse.org/reference/scale_manual.html).

## Value

A ggplot2 discrete scale.

## References

[UC Davis Health Graphic Standards:
Colors](https://health.ucdavis.edu/graphic-standards/colors/)

## Examples

``` r
ggplot2::ggplot(
  iris,
  ggplot2::aes(Sepal.Length, Petal.Length, colour = Species)
) +
  ggplot2::geom_point() +
  scale_colour_ucdh()
```
