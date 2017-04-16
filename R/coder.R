
#' Return probset class
coder_probsets <- function() {
  probset_path <- system.file("probsets",
                              package = "coder")
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

.coder <- function(probset = NULL) {
  if (is.null(probset)) {
    probset <- coder_probsets()
    options(coder.probset = probset)
    .coder(probset)
  } else {
    stopifnot(inherits(probset, "coder.probset"))
    prob <- coder_prob(probset)
    options(coder.prob = prob)
    cat("view_prob():\n")
    cat("edit_prob():\n")
    cat("test_prob():\n")
    cat("submit_prob():\n")
  }
}

#' Coder
#'
#' @export
#' @examples
#' \dontrun{
#' coder()
#' }
coder <- function() {
  cat("Welcome to coder\n")
  tryCatch({
    options(coder.user = user())
  }, error = function(e) {
    message("Failed to create user account")
    print(e)
  })
  .coder()
}
