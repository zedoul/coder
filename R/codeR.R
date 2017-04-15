#' Return probset class
coder_probsets <- function() {
  probset_path <- file.path(find.package(getOption("coder.pkgname")),
                            "probsets")
  probset_paths <- list.dirs(probset_path,
                             full.names = T,
                             recursive = F)

  menu_probsets(probset_paths)
}

#' Return prob class
coder_prob <- function(probset) {
  stopifnot(inherits(probset, "coder.probset"))
  menu_probset(probset)
}

#' Coder
#'
#' @export
#' @examples
#' \dontrun{
#' coder()
#' }
coder <- function(probset = NULL) {
  cat("Welcome to coder\n")
  if (is.null(probset)) {
    probset <- coder_probsets()
    options(coder.probset = probset)
    coder(probset)
  } else {
    stopifnot(inherits(probset, "coder.probset"))
    prob <- coder_prob(probset)
    options(coder.prob = prob)
    cat("prob_view() to start\n")
  }
}
