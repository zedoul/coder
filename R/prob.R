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
  test_sample_path <- file.path(prob_path, "00_test_sample.R")
  test_system_path <- file.path(prob_path, "00_test_system.R")
  template_path <- file.path(prob_path, "00_template.R")
  stopifnot(file.exists(rd_path))
  stopifnot(file.exists(test_sample_path))
  stopifnot(file.exists(test_system_path))
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
                 test_sample_path = test_sample_path,
                 test_system_path = test_system_path,
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
#' @importFrom testthat test_file
solution_test <- function(solution_path,
                          test_path) {
  # TODO: Do not use \code{source}, this can't be good. More specifically,
  # implement \code{source.coder.prob} in better and secured way compared to
  # \code{base::source}
  test_env <- new.env()
  source(solution_path, local = test_env)
  res <- testthat::test_file(test_path, env = test_env)
  stopifnot(as.data.frame(res)[1, "failed"] == 0)
}

test.coder.prob <- function(.prob) {
  is_failed <- F

  tryCatch({
    solution_test(.prob$solution_path,
                  .prob$test_sample_path)
  }, error = function(e) {
    is_failed <<- T
  })

  if (!is_failed) {
    message("All testcases have been passed\n")
  }
}

test <- function(.prob) {
  UseMethod("test")
}

submit.coder.prob <- function(.prob) {
  # I know this function looks duplicated with test.coder.prob, and this is
  # intended: let's play dumb during the development stage
  is_failed <- F

  start_time <- Sys.time()

  tryCatch({
    solution_test(.prob$solution_path,
                  .prob$test_system_path)
  }, error = function(e) {
    is_failed <<- T
  })

  end_time <- Sys.time()

  if (!is_failed) {
    message("All systemtests have been passed\n")
    message(end_time - start_time, "(s) \n")
  }

  # Save user result into user_data
  .user <- getOption("coder.user")

  if (!is.null(.user)) {
    # Copy solution and its score into user_data
    stopifnot(file.exists(.prob$solution_path))
    stopifnot(file.exists(.user$path))

    target_path <- file.path(.user$path,
                             .user$name,
                             .prob$probset_name,
                             .prob$name,
                             paste0(.user$name, ".R"))
    if (!dir.exists(dirname(target_path))) {
      dir.create(dirname(target_path), recursive = T)
    }

    res <- file.copy(from = .prob$solution_path,
                     to = target_path)

    if (res) {
      cat("Solution has been saved successfully\n")
    } else {
      message("Failed to save solution into:\n",
              target_path)
    }
  }
}

submit <- function(.prob) {
  UseMethod("submit")
}
