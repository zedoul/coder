menu_start.default <- function(e) {
  cat("Welcome to coder\n")
  choices <- c("Level 1",
               "Level 2",
               "Level 3")
  .title <- "title"
  .det <-  menu(choices, title = .title)
}

menu_start <- function(e, ...) UseMethod("menu_start")
