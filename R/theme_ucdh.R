#' UCDH ggplot2 theme
#'
#' Applies UC Davis Health styling using colors from the UC Davis print
#' palette.
#'
#' @param base_size Base font size in points.
#' @param base_family Base font family.
#'
#' @return A ggplot2 theme.
#' @references
#' [UC Davis Health Graphic Standards: Colors](https://health.ucdavis.edu/graphic-standards/colors/)
#' @export
#'
#' @examples
#' ggplot2::ggplot(
#'   iris,
#'   ggplot2::aes(Sepal.Length, Petal.Length, colour = Species)
#' ) +
#'   ggplot2::geom_point() +
#'   scale_colour_ucdh() +
#'   theme_ucdh()
theme_ucdh <- function(base_size = 11, base_family = "") {
  ggplot2::theme_minimal(
    base_size = base_size,
    base_family = base_family
  ) +
    ggplot2::theme(
      title = ggplot2::element_text(colour = "#002855"),
      plot.title = ggplot2::element_text(face = "bold"),
      plot.tag = ggplot2::element_text(colour = "#C99700", face = "bold"),
      axis.title = ggplot2::element_text(face = "bold"),
      panel.grid.major = ggplot2::element_line(colour = "#B1B3B3"),
      panel.grid.minor = ggplot2::element_blank(),
      strip.background = ggplot2::element_rect(
        fill = "#002855",
        colour = NA
      ),
      strip.text = ggplot2::element_text(colour = "white", face = "bold"),
      legend.title = ggplot2::element_text(face = "bold"),
      legend.key = ggplot2::element_rect(fill = "white", colour = NA),
      panel.background = ggplot2::element_rect(fill = "white", colour = NA),
      plot.background = ggplot2::element_rect(fill = "white", colour = NA)
    )
}

ucdh_print_palette <- c(
  "#002855",
  "#ED8B00",
  "#00B5E2",
  "#C6007E",
  "#78BE20",
  "#642667",
  "#BA0C2F",
  "#008EAA"
)

#' UCDH discrete scales
#'
#' Applies colors from the bright UC Davis print palette to discrete colour or
#' fill aesthetics.
#'
#' @param ... Arguments passed to [ggplot2::scale_colour_manual()] or
#'   [ggplot2::scale_fill_manual()].
#'
#' @return A ggplot2 discrete scale.
#' @references
#' [UC Davis Health Graphic Standards: Colors](https://health.ucdavis.edu/graphic-standards/colors/)
#' @export
#'
#' @examples
#' ggplot2::ggplot(
#'   iris,
#'   ggplot2::aes(Sepal.Length, Petal.Length, colour = Species)
#' ) +
#'   ggplot2::geom_point() +
#'   scale_colour_ucdh()
scale_colour_ucdh <- function(...) {
  ggplot2::scale_colour_manual(..., values = ucdh_print_palette)
}

#' @rdname scale_colour_ucdh
#' @export
scale_color_ucdh <- scale_colour_ucdh

#' @rdname scale_colour_ucdh
#' @export
scale_fill_ucdh <- function(...) {
  ggplot2::scale_fill_manual(..., values = ucdh_print_palette)
}
