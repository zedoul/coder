# User account, data, prepare for commit

#' @importFrom whoami whoami
get_user_name <- function() {
  user_info <- whoami::whoami()
  user_name_key <- "email_address"
  stopifnot(user_name_key %in% names(user_info))
  as.character(user_info[user_name_key])
}

get_user_data_path <- function(user_name) {
  .basename <- getOption("coder.userdata")
  system.file(.basename, package = getOption("coder.pkgname"))
}


