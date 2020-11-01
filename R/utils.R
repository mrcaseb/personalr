# Taken from usethis ------------------------------------------------------

use_dependency <- function(package, type, min_version = NULL) {
  stopifnot(is_string(package))
  stopifnot(is_string(type))

  if (package != "R" && !is_installed(package)) {
    usethis::ui_stop(c(
      "{ui_value(package)} must be installed before you can ",
      "take a dependency on it."
    ))
  }

  if (isTRUE(min_version)) {
    min_version <- utils::packageVersion(package)
  }
  version <- if (is.null(min_version)) "*" else paste0(">= ", min_version)

  types <- c("Depends", "Imports", "Suggests", "Enhances", "LinkingTo")
  names(types) <- tolower(types)
  type <- types[[match.arg(tolower(type), names(types))]]

  deps <- desc::desc_get_deps(usethis::proj_get())

  existing_dep <- deps$package == package
  existing_type <- deps$type[existing_dep]
  existing_ver <- deps$version[existing_dep]
  is_linking_to <- (existing_type != "LinkingTo" & type == "LinkingTo") |
    (existing_type == "LinkingTo" & type != "LinkingTo")

  # No existing dependency, so can simply add
  if (!any(existing_dep) || any(is_linking_to)) {
    usethis::ui_done("Adding {ui_value(package)} to {ui_field(type)} field in DESCRIPTION")
    desc::desc_set_dep(package, type, version = version, file = usethis::proj_get())
    return(invisible())
  }

  existing_type <- setdiff(existing_type, "LinkingTo")
  delta <- sign(match(existing_type, types) - match(type, types))
  if (delta < 0) {
    # don't downgrade
    usethis::ui_warn(
      "Package {ui_value(package)} is already listed in \\
      {ui_value(existing_type)} in DESCRIPTION, no change made."
    )
  } else if (delta == 0 && !is.null(min_version)) {
    # change version
    upgrade <- existing_ver == "*" || numeric_version(min_version) > version_spec(existing_ver)
    if (upgrade) {
      usethis::ui_done(
        "Increasing {ui_value(package)} version to {ui_value(version)} in DESCRIPTION"
      )
      desc::desc_set_dep(package, type, version = version, file = usethis::proj_get())
    }
  } else if (delta > 0) {
    # upgrade
    if (existing_type != "LinkingTo") {
      usethis::ui_done(
        "
        Moving {ui_value(package)} from {ui_field(existing_type)} to {ui_field(type)} \\
        field in DESCRIPTION
        "
      )
      desc::desc_del_dep(package, existing_type, file = usethis::proj_get())
      desc::desc_set_dep(package, type, version = version, file = usethis::proj_get())
    }
  }

  invisible()
}

is_installed <- function(pkg) {
  requireNamespace(pkg, quietly = TRUE)
}

check_for_package <- function(package){
  if (package != "R" && !is_installed(package)) {
    usethis::ui_stop(c(
      "Package {usethis::ui_value(package)} must be installed before you can ",
      "take a dependency on it."
    ))
  }
}

# Taken from https://github.com/radiant-rstats/radiant.data/blob/m --------

is_string <- function(x) {
  length(x) == 1 && is.character(x) && !is_empty(x)
}

is_empty <- function(x, empty = "\\s*") {
  is_not(x) || (length(x) == 1 && grepl(paste0("^", empty, "$"), x))
}

is_not <- function(x) {
  length(x) == 0 || (length(x) == 1 && is.na(x))
}
