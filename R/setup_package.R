#' Setup Personal Package
#'
#' A function to setup a new personal package or update an existing package.
#'
#' @param path The path in which the package shall be created.
#'   If it exists, it is used. If it does not exist, it is created, provided
#'   that the parent path exists.
#' @param packagename The name of the newly generated package. It will be
#'   checked to make sure it meets R package naming conventions.
#' @param core A vector or list containing package names that shall be attached
#'   when the newly generated package is loaded. The packages must be installed
#'   on the current system, otherwise an error will be shown.
#' @export
#' @examples
#' \donttest{
#' # create package "mypackage" in temporary directory with
#' # the core packages dplyr, glue and purrr
#' withr::with_tempdir({
#'   install.packages(
#'     c("dplyr", "glue", "purrr"),
#'     repos = "http://cran.us.r-project.org"
#'   )
#'   setup_package(
#'     path = tempdir(),
#'     packagename = "mypackage",
#'     core = c("dplyr", "glue", "purrr")
#'   )
#' })
#' }
setup_package <- function(path, packagename, core = NULL) {
  # check the core vector
  purrr::walk(core, check_for_package)

  # create the package and use the path for next steps
  path <- usethis::create_package(
    glue::glue("{path}/{packagename}"),
    rstudio = rstudioapi::isAvailable(),
    open = FALSE,
    fields = list(
      Version = "1.0.0"
    )
  )

  # move to the correct working directory
  usethis::local_project(path)

  # Add package doc file
  usethis::use_template(
    "packagename-package.R",
    glue::glue("R/{packagename}-package.R")
  )

  # Add Readme as markdown file because we want to keep it easy
  usethis::use_template(
    "package-README",
    "README.md",
    data = package_data(),
    open = FALSE,
    package = "personalr"
  )

  # Add core packages to "Imports" and save core script
  purrr::walk(c(core, "cli", "crayon", "rstudioapi"), use_dependency, "Imports")
  usethis::use_tidy_description()
  usethis::write_over(usethis::proj_path("R/core.R"), create_core_script(core))

  # Add template files
  templates <- c("attach", "conflicts", "pipe", "utils", "zzz")
  purrr::walk(templates, add_template)

  # Use the package name in all templates
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
    quiet = FALSE,
    upgrade = FALSE
  )

  # Now activate project
  usethis::proj_activate(path)
}


