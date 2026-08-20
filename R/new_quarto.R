#' @title Create a new Quarto Document from Template
#' @param filename Character string. The name of the file without the ".qmd"
#'  extension. Only letters, numbers, hyphens, and underscores are allowed. When
#'  `NULL` (the default) an interactive file explorer pop-up is opened to choose
#'  the file name and location.
#' @param path Character string. Directory where the file will be created.
#'  Defaults to the current project's base directory.
#' @param gist Character string. Qmd template file to create/open.
#' @returns Opens file after creating the Quarto document.
#' @export
#'
new_quarto <- function(
  filename = NULL,
  path = here::here(),
  gist = c("no_logo", "ctsc", "hac")) {

  gist <- match.arg(gist)
  # Validate path
  if (is.null(path) || !dir.exists(path)) {
    stop("Invalid `path`. Please enter a valid project directory.")
  }

  # Prompt for a file name/location via a file explorer pop-up when NULL
  if (is.null(filename)) {
    selected <- choose_quarto_file(path)
    if (is.null(selected) || length(selected) == 0 || selected == "") {
      stop("Invalid filename. Please input a value.")
    }
    path <- dirname(selected)
    filename <- basename(selected)
  }

  # Remove .qmd if accidentally typed
  filename <- stringr::str_replace_all(filename, ".qmd$", "")

  # Validate filename: part 2
  if (!is.character(filename)) stop("Invalid filename: must be character.")
  if (!grepl("^[a-zA-Z0-9_-]+$", filename)) {
    stop(
      "Invalid filename. Use only letters, numbers, hyphens, and underscores."
    )
  }

  # Normalize the path for consistency
  path <- normalizePath(path, mustWork = TRUE)

  if (file.access(path, mode = 2) != 0) {
    stop(
      sprintf(
        paste0(
          "You do not have permission to write to the path location: ",
          "%s\nTry `rUM::write_quarto(filename = '', path = '')`"
        ),
        path
      )
    )
  }

  # Set up full file path
  the_quarto_file <- file.path(path, paste0(filename, ".qmd"))

  # Check for existing Quarto doc
  if (file.exists(the_quarto_file)) {
    stop(sprintf("%s.qmd already exists in the specified path.", filename))
  }

  # Write the Quarto file based on template
  gist <- paste0("gists/", gist, ".qmd")
  template_path <- system.file(gist, package = "bsu.tools")

  if (template_path == "") {
    stop("Could not find Quarto template in package installation")
  }

  file.copy(from = template_path, to = the_quarto_file, overwrite = FALSE)

  # Open the new template upon successful copy
  if (file.exists(the_quarto_file)) {
    usethis::edit_file(the_quarto_file)
  } else {
    stop("The file does not exist.")
  }

  invisible(NULL)
}

# Open a file explorer pop-up to choose the Quarto file name and location.
# Returns the selected path (without extension) or NULL if cancelled.
choose_quarto_file <- function(path) {
  if (!interactive() || !rstudioapi::isAvailable()) {
    stop("Invalid filename. Please input a value.")
  }

  selected <- rstudioapi::selectFile(
    caption = "Create New Quarto Document",
    label = "Create",
    path = path,
    filter = "Quarto Files (*.qmd)",
    existing = FALSE
  )

  if (is.null(selected)) {
    return(NULL)
  }

  # Remove .qmd if present so downstream logic can append it consistently
  stringr::str_replace_all(selected, "\\.qmd$", "")
}
