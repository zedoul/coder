menu_start <- function(e, ...) UseMethod("menu_start")
menu_probsets <- function(e, ...) UseMethod("menu_probsets")
menu_probset <- function(e, ...) UseMethod("menu_probset")

.probset_path <- file.path(find.package(getOption("coder.pkgname")),
                           "probsets")
.probsets_paths <- list.dirs(probset_path, full.names = T, recursive = F)
.recom_path <- file.path(find.package(getOption("coder.pkgname")),
                         "probsets", "recommeded.yaml")

menu_start.default <- function(e) {
  cat("Welcome to coder\n")

  .det <- menu_probsets(e)
}

menu_probsets.default <- function(e) {
  probset <- NULL
  is_selected <- F
  while(is_selected == F) {
    .title <- "Select problem sets"
    probset_names <- basename(.probsets_paths)
    probset <-  select.list(probset_names,
                         title = .title,
                         graphic= F)

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
  .probs_paths <- list.dirs(.probset_path, full.names = T, recursive = F)

  cat("Select your level\n")
  .title <- "title"
  select.list(courses,
              title = .title, graphic= F)
}
