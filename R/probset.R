probset <- function(probset_name,
                    probset_path = NULL) {
  if (is.null(probset_path)) {
    probset_path <- system.file("probsets", probset_name,
                                package = "coder")
  }
  stopifnot(dir.exists(probset_path))

  structure(list(name = probset_name,
                 path = probset_path),
            class = "coder.probset")
}
