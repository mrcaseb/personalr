#' Setup Personal Package
#' @export
#' @examples
#' if (FALSE) {
#'   setup_package("..", "mypackage", core = c("dplyr", "glue", "purrr"))
#' }
setup_package <- function(path,
                          packagename,
                          core = NULL) {
  # check the core vector
  purrr::walk(core, check_for_package)

  # create the package and use the path for next steps
  path <- usethis::create_package(
    glue::glue("{path}/{packagename}"),
    rstudio = rstudioapi::isAvailable(),
    open = FALSE
  )

  # move to the correct working directory
  usethis::local_project(path)

  # Add package doc file and Readme.Rmd
  usethis::use_template(
    "packagename-package.R",
    glue::glue("R/{packagename}-package.R")
  )
  usethis::use_readme_rmd(open = FALSE)

  # Add core packages to "Imports" and save core script
  purrr::walk(c(core, "cli", "crayon", "rstudioapi"), use_dependency, "Imports")
  usethis::use_tidy_description()
  usethis::write_over(usethis::proj_path("R/core.R"), create_core_script(core))

  # Add template files
  templates <- c("attach", "conflicts", "pipe", "utils", "zzz")
  purrr::walk(templates, add_template)

  # replace some stuff
  xfun::gsub_dir(
    "personalr_to_replace",
    packagename,
    dir = usethis::proj_path("R"),
    ext = "R"
  )

  # Now document and install the package
  usethis::ui_todo("Updating documentation and installing {packagename}...")

  devtools::document(pkg = path, quiet = TRUE)
  devtools::install(
    pkg = path,
    reload = FALSE,
    build = FALSE,
    force = TRUE,
    quiet = FALSE
  )

  # Now activate project
  usethis::proj_activate(path)
}

use_data_raw()
