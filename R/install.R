#' @importFrom devtools install_github
#' @export
install_probset <- function(course_name = NULL,
                           force = FALSE){
  if(is.null(course_name) && is.null(swc_path)){
    swc_path <- file.choose()
  }
}

#' List local problem sets
#'
#' @export
list_probset_local <- function() {
}

#' List remote problem sets
#'
#' Support both file and github
#'
#' @export
list_probset_remote <- function() {
}
