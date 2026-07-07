# BSU HTML R Markdown Output Format

Creates an R Markdown HTML output format that applies the BSU CSS
template. Wraps
[`bookdown::html_document2()`](https://pkgs.rstudio.com/bookdown/reference/html_document2.html)
with the package's default stylesheet.

## Usage

``` r
html_bsu(...)
```

## Arguments

- ...:

  Additional arguments passed to
  [`bookdown::html_document2()`](https://pkgs.rstudio.com/bookdown/reference/html_document2.html).

## Value

An R Markdown output format object.
