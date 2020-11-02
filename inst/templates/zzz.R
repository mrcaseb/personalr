.onAttach <- function(...) {
  needed <- core[!is_attached(core)]
  if (length(needed) == 0)
    return()

  crayon::num_colors(TRUE)
  personalr_to_replace_attach()

  # if (!"package:conflicted" %in% search()) {
  #   x <- personalr_to_replace_conflicts()
  #   msg(personalr_to_replace_conflict_message(x), startup = TRUE)
  # }

  msg(cli::rule(right = crayon::bold("Ready to go!")),startup = TRUE)

}

is_attached <- function(x) {
  paste0("package:", x) %in% search()
}
