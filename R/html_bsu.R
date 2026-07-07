#' @title BSU HTML R Markdown Output Format
#' @description
#' Creates an R Markdown HTML output format that applies the BSU CSS template.
#' Wraps [bookdown::html_document2()] with the package's default stylesheet.
#' @param ... Additional arguments passed to [bookdown::html_document2()].
#' @return An R Markdown output format object.
#' @export

html_bsu <- function(...) {
  css_path <- system.file(
    "styling/template_css.css",
    package = "bsu.tools"
  )

  bookdown::html_document2(
    css = css_path,
    ...
  )
}
