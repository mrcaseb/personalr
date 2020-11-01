#' Setup Personal Package
#'
#' @inheritParams usethis::create_package

setup_package <- function(path,
                          core = NULL,
                          fields = list(),
                          rstudio = rstudioapi::isAvailable(),
                          roxygen = TRUE,
                          check_name = TRUE,
                          open = rlang::is_interactive()) {

  # stopifnot(all(purrr::map_lgl(core, is_string)))

  purrr::walk(core, check_for_package)

  open <- FALSE

  usethis::create_package(
    path = path,
    fields = fields,
    rstudio = rstudio,
    roxygen = roxygen,
    check_name = check_name,
    open = open
  )

  usethis::use_package_doc(open = open)

  purrr::walk(core, use_dependency, "Imports")
}
