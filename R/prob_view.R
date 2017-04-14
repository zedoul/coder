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

create_template <- function(prob_path) {
  # prob_path <- system.file("probsets", "level1", "01_helloworld",
  #                          package = "coder")
  template_file <- file.path(prob_path, "00_template.R")
  stopifnot(file.exists(template_file))

  tempfile_path <- tempfile(fileext = ".R")
  tempfile_conn <- file(tempfile_path)
  writeLines(readLines(template_file),
             tempfile_conn)

  cat("Template has been created in:\n",
      tempfile_path, "\n")
}

submit <- function(prob_path,
                   tempfile_path) {
  # TODO: Implement "source" in better and secured way compared to
  #       "base::source"
  # TODO: Implement "testcases run"
  # TODO: Implement "system testing"
}
