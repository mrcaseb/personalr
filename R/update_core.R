#' Update Core of Personal Package
#'
#' Updates the "core" of a personal package created with personalr. It can
#' either append another package to the current core or overwrite it
#' with a new core.
#'
#' @inheritParams setup_package
#' @param append If \code{TRUE} the packages of the argument \code{core} will
#'   be appended to the current core and the package version will be increased
#'   on the "patch" level. Otherwise \code{core} will be overwritten and the
#'   package version will be increased on the "minor" level.
#' @export
update_core <- function(path, packagename, core = NULL, append = TRUE) {
  # check the core vector
  purrr::walk(core, check_for_package)

  # create the package and use the path for next steps
  if (!is_package(path)) {
    path <- fs::path_expand(glue::glue("{path}/{packagename}"))
  }

  # move to the correct working directory
  usethis::local_project(path)

  # Remove deps if append = FALSE
  if (!isTRUE(append)) {
    desc::desc_del_deps()
  }

  # write new deps and tidy up DESCRIPTION
  purrr::walk(c(core, "cli", "crayon", "rstudioapi"), use_dependency, "Imports")
  usethis::use_tidy_description()

  # get old core packages
  if (isTRUE(append)) {
    old_core <- utils::packageDescription(packagename)$Imports %>%
      strsplit(",\n") %>%
      unlist()
  } else {
    old_core <- NULL
  }

  # combine old and new core
  new_core <- c(
    core,
    old_core[which(!old_core %in% c("cli", "crayon", "rstudioapi"))]
  ) %>%
    sort()

  output_string <- glue::glue(
    "If you really want to update your core you'll have to",
    "confirm the following dialogue...!"
  )

  usethis::ui_info("{output_string}\n")

  # write new core file
  usethis::write_over(
    usethis::proj_path("R/core.R"),
    create_core_script(new_core)
  )

  if (isTRUE(append)) {
    usethis::use_version("patch")
  } else {
    usethis::use_version("minor")
  }

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

  return(invisible(TRUE))
}
