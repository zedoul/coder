menu_start <- function(e, ...) UseMethod("menu_start")
menu_probsets <- function(e, ...) UseMethod("menu_probsets")
menu_probset <- function(e, ...) UseMethod("menu_probset")

.recom_path <- file.path(find.package(getOption("coder.pkgname")),
                         "probsets", "recommeded.yaml")

menu_start.default <- function(e) {
  cat("Welcome to coder\n")

  .probset_path <- file.path(find.package(getOption("coder.pkgname")),
                             "probsets")
  .probsets_paths <- list.dirs(.probset_path, full.names = T, recursive = F)

  .det <- menu_probsets(e, .probsets_paths)
}

menu_probsets.default <- function(e, .probsets_paths) {
  probset <- NULL
  is_selected <- F
  while(is_selected == F) {
    .title <- "Select problem sets"
    probset_names <- basename(.probsets_paths)
    probset <-  select.list(probset_names,
                            title = .title,
                            graphic= F)
    if (probset == "") {
      menu_start(e)
    }

    cat("\n")
    .title <- paste("Problem set:", probset)
    .sel <-  select.list(c("Yes", "No"),
                         title = .title,
                         graphic= F)
    if (.sel == "Yes") is_selected <- T
  }

  .det <- menu_probset(e, probset)
}

menu_probset.default <- function(e, probset) {
  .probset_path <- file.path(find.package(getOption("coder.pkgname")),
                             "probsets", probset)
  .prob_paths <- list.dirs(.probset_path, full.names = T, recursive = F)
  .prob_names <- basename(.prob_paths)

  .title <- "Select problem"
  .prob_name <-  select.list(.prob_names,
                            title = .title,
                            graphic= F)
  if (.prob_name == "") {
    menu_probsets(e)
  }

  cat("\n")
  .title <- paste("Problem:", .prob_name)
  .sel <-  select.list(c("Yes", "No"),
                       title = .title,
                       graphic= F)
  if (.sel == "Yes") is_selected <- T

  prob_path <- file.path(.probset_path, .prob_name)
  prob_view(e, prob_path)
}
