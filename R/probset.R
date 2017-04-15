probset <- function(probset_name,
                    probset_path = NULL) {
  if (is.null(probset_path)) {
    probset_path <- file.path(find.package(getOption("coder.pkgname")),
                              "probsets", probset_name)
  }
  stopifnot(dir.exists(probset_path))

  structure(list(name = probset_name,
                 path = probset_path),
            class = "coder.probset")
}
