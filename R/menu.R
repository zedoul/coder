mainMenu.default <- function(e) {
  cat("Welcome to coder\n")
  cat("Menu:\n")
  cat("1- Level 1\n")
  cat("2- Level 2\n")
  cat("3- Level 3\n\n")
  cat("Selection: ")
  .det <- readline()
}

mainMenu <- function(e, ...) UseMethod("mainMenu")
