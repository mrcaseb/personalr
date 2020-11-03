# Run this to update the DESCRIPTION
imports <- c(
  "purrr",
  "usethis",
  "rstudioapi",
  "glue",
  "xfun",
  "devtools",
  "utils",
  "desc",
  "rprojroot",
  "magrittr",
  "fs",
  "withr"
)
purrr::walk(imports, usethis::use_package, "Imports")
usethis::use_tidy_description()
rm(imports)
