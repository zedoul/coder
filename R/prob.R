#' Create prob class
prob <- function(probset_name,
                 prob_name,
                 prob_path = NULL) {
  if (is.null(prob_path)) {
    prob_path <- file.path(find.package(getOption("coder.pkgname")),
                           "probsets", probset_name, prob_name)
  }

  # Create files for given problem
  stopifnot(dir.exists(prob_path))
  rd_path <- file.path(prob_path, "00_problem.Rd")
  yml_path <- file.path(prob_path, "00_problem.yml")
  systemtest_path <- file.path(prob_path, "00_systemtest.rda")
  template_path <- file.path(prob_path, "00_template.R")
  stopifnot(file.exists(rd_path))
  stopifnot(file.exists(yml_path))
  stopifnot(file.exists(systemtest_path))
  stopifnot(file.exists(template_path))

  # Create solution file
  solution_path <- tempfile(fileext = ".R")
  solution_conn <- file(solution_path)
  writeLines(readLines(template_path),
             solution_conn)
  close(solution_conn)
  stopifnot(file.exists(solution_path))

  structure(list(probset_name = probset_name,
                 name = prob_name,
                 path = prob_path,
                 rd_path = rd_path,
                 yml_path = yml_path,
                 systemtest_path = systemtest_path,
                 template_path = template_path,
                 solution_path = solution_path),
            class = "coder.prob")
}
