#' @importFrom tools Rd2txt
#' @export
prob_view <- function(prob = NULL) {
  if (is.null(prob)) {
    prob <- getOption("coder.prob")
  }
  stopifnot(inherits(prob, "coder.prob"))

  temp_rtxt <- tools::Rd2txt(prob$rd_path,
                             out = tempfile("Rtxt"))
  file.show(temp_rtxt,
            title = gettextf("Problem: %s",
                             sQuote(basename(prob$name))),
            delete.file = TRUE)
}

submit <- function(prob,
                   tempfile_path) {
  stopifnot(inherits(prob, "coder.prob"))

  # TODO: Implement "source" in better and secured way compared to
  #       "base::source"
  # TODO: Implement "testcases run"
  # TODO: Implement "system testing"
}
