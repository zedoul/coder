#' Create prob class
prob <- function(probset_name,
                 prob_name,
                 prob_path = NULL) {
  if (is.null(prob_path)) {
    prob_path <- system.file("probsets", probset_name, prob_name,
                             package = "coder")
  }

  # Create files for given problem
  stopifnot(dir.exists(prob_path))
  rd_path <- file.path(prob_path, "00_problem.Rd")
  yml_path <- file.path(prob_path, "00_problem.yml")
  template_path <- file.path(prob_path, "00_template.R")
  stopifnot(file.exists(rd_path))
  stopifnot(file.exists(yml_path))
  stopifnot(file.exists(template_path))

  # Create solution file
  solution_path <- tempfile(fileext = ".R")
  solution_conn <- file(solution_path)
  writeLines(readLines(template_path),
             solution_conn)
  close(solution_conn)
  stopifnot(file.exists(solution_path))

  # Return coder.prob class
  structure(list(probset_name = probset_name,
                 name = prob_name,
                 path = prob_path,
                 rd_path = rd_path,
                 yml_path = yml_path,
                 template_path = template_path,
                 solution_path = solution_path),
            class = "coder.prob")
}

#' @export
view_prob <- function() {
  view(getOption("coder.prob"))
}

#' @export
edit_prob <- function() {
  edit(getOption("coder.prob"))
}

#' @export
test_prob <- function() {
  test(getOption("coder.prob"))
}

#' @export
submit_prob <- function() {
  submit(getOption("coder.prob"))
}

#' @importFrom tools Rd2txt
view.coder.prob <- function(prob) {
  temp_rtxt <- tools::Rd2txt(prob$rd_path,
                             out = tempfile("Rtxt"))
  file.show(temp_rtxt,
            title = gettextf("Problem: %s",
                             sQuote(basename(prob$name))),
            delete.file = TRUE)
}

view <- function(.prob) {
  UseMethod("view")
}

#' @importFrom tools Rd2txt
edit.coder.prob <- function(prob) {
  file.edit(prob$solution_path)
}

#' @importFrom yaml yaml.load_file
solution_test <- function(solution_path, testcase) {
  # TODO: Do not use \code{source}, this can't be good. More specifically,
  # implement \code{source.coder.prob} in better and secured way compared to
  # \code{base::source}
  test_env <- new.env()
  source(solution_path, local = test_env)
  expr <- testcase$input
  ans <- eval(parse(text = expr), envir = test_env)
  stopifnot(testcase$output == ans)
}

#' @importFrom yaml yaml.load_file
test.coder.prob <- function(.prob) {
  desc <- yaml::yaml.load_file(.prob$yml_path)
  testcases <- desc$testcases
  is_failed <- F

  for (i in 1:length(testcases)) {
    # TODO: Use txtProgressBar instead
    cat("Testing", i, "... ")
    testcase <- testcases[[i]]
    tryCatch({
      solution_test(.prob$solution_path, testcase)
      cat("passed\n")
    }, error = function(e) {
      is_failed <<- T
      cat("failed\n")
    })
  }

  if (!is_failed) {
    cat("All testcases have been passed\n")
  }
}

test <- function(.prob) {
  UseMethod("test")
}

submit.coder.prob <- function(.prob) {
  # I know this function looks duplicated with test.coder.prob, and this is
  # intended: let's play dumb during the development stage
  desc <- yaml::yaml.load_file(.prob$yml_path)
  testcases <- desc$systemtests
  is_failed <- F

  for (i in 1:length(testcases)) {
    cat("Testing", i, "... ")
    testcase <- testcases[[i]]
    tryCatch({
      solution_test(.prob$solution_path, testcase)
      cat("passed\n")
    }, error = function(e) {
      is_failed <<- T
      cat("failed\n")
    })
  }

  if (!is_failed) {
    cat("All systemtests have been passed\n")
  }
}

submit <- function(.prob) {
  UseMethod("submit")
}
