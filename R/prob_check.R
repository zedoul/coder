#' @importFrom yaml yaml.load_file
prob_desc <- function(prob_path) {
  prob_desc_path <- file.path(find.package(getOption("coder.pkgname")),
                              prob_path)
  yaml::yaml.load_file(prob_desc_path)
}
