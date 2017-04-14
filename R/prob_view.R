prob_view <- function(e, ...) UseMethod("prob_view")

#' @importFrom tools Rd2txt
prob_view.default <- function(e, prob_path) {
  stopifnot(dir.exists(prob_path))
  prob_rd_path <- file.path(prob_path, "00_problem.Rd")

  temp <- tools::Rd2txt(prob_rd_path,
                        out = tempfile("Rtxt"))
  file.show(temp,
            title = gettextf("Problem: %s",
                             sQuote(basename(prob_path))),
            delete.file = TRUE)
}
