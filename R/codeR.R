#' Coder
#'
#' @export
#' @examples
#' \dontrun{
#' coder()
#' }
coder <- function(resume.class = "default", ...) {
  # Create new environment
  removeTaskCallback("mini")

  e <- new.env(globalenv())
  class(e) <- c(class(e),
                resume.class)

  cb <- function(expr, val, ok, vis, data = e) {
    e$expr <- expr
    e$val <- val
    e$ok <- ok
    e$vis <- vis
    resume(e, ...)
  }
  addTaskCallback(cb, name = "mini")

  # Remove non-informative task callback prints
  invisible()
}

resume.default <- function(e, ...) {
  # Specify additional arguments
  menu_start(e)
}

resume <- function(...) UseMethod("resume")
