menu_probsets <- function(e, ...) UseMethod("menu_probsets")
menu_probset <- function(e, ...) UseMethod("menu_probset")

.recom_path <- system.file("probsets", "recommeded.yaml", package = "coder")

#' Show list of problem sets
menu_probsets.default <- function(probset_paths) {
  selected_probset_name <- NULL
  is_selected <- F
  while(is_selected == F) {
    .title <- "Select problem sets"
    probset_names <- basename(probset_paths)
    selected_probset_name <-  select.list(probset_names,
                                          title = .title,
                                          graphic= F)
    if (selected_probset_name %in% probset_names) {
      is_selected <- T
    }
  }

  probset(selected_probset_name)
}

#' Show problem set
#'
#' Currently, it shows just list of problems
menu_probset.default <- function(probset) {
  stopifnot(inherits(probset, "coder.probset"))
  .prob_paths <- list.dirs(probset$path, full.names = T, recursive = F)
  .prob_names <- basename(.prob_paths)

  is_selected <- F
  while(is_selected == F) {
    .title <- "Select problem"
    .prob_name <-  select.list(.prob_names,
                              title = .title,
                              graphic= F)

    if (.prob_name %in% .prob_names) {
      is_selected <- T
    }
  }

  # Create prob
  prob(probset$name,
       .prob_name)
}
