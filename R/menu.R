menu_start <- function(e, ...) UseMethod("menu_start")
menu_probsets <- function(e, ...) UseMethod("menu_probsets")
menu_probset <- function(e, ...) UseMethod("menu_probset")

.recom_path <- file.path(find.package(getOption("coder.pkgname")),
                         "probsets", "recommeded.yaml")

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
    if (selected_probset_name == "") {
      break
    }

    cat("\n")
    .title <- paste("Problem set:", selected_probset_name)
    .sel <-  select.list(c("Yes", "No"),
                         title = .title,
                         graphic= F)
    if (.sel == "Yes") {
      break
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

  .title <- "Select problem"
  .prob_name <-  select.list(.prob_names,
                            title = .title,
                            graphic= F)
  if (.prob_name == "") {
    return(NULL)
  }

  cat("\n")
  .title <- paste("Problem:", .prob_name)
  .sel <-  select.list(c("Yes", "No"),
                       title = .title,
                       graphic= F)
  if (.sel == "Yes") is_selected <- T

  # Create prob
  prob(probset$name,
       .prob_name)
}
