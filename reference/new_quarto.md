# Create a new Quarto Document from Template

Create a new Quarto Document from Template

## Usage

``` r
new_quarto(
  filename = NULL,
  path = here::here(),
  gist = c("no_logo", "ctsc", "hac")
)
```

## Arguments

- filename:

  Character string. The name of the file without the ".qmd" extension.
  Only letters, numbers, hyphens, and underscores are allowed. When
  `NULL` (the default) an interactive file explorer pop-up is opened to
  choose the file name and location.

- path:

  Character string. Directory where the file will be created. Defaults
  to the current project's base directory.

- gist:

  Character string. Qmd template file to create/open. Primary values are
  `"no_logo"`, `"ctsc"`, and `"hac"`. Legacy aliases `"no_logo_quarto"`,
  `"ctsc_quarto"`, and `"hac_quarto"` are also accepted.

## Value

Opens file after creating the Quarto document.
