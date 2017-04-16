#' User account, data, prepare for commit

#' @importFrom whoami whoami
#' @export
user <- function() {
  user_info <- whoami::whoami()
  user_name_key <- "email_address"
  stopifnot(user_name_key %in% names(user_info))
  user_name <- as.character(user_info[user_name_key])
  user_path <- system.file("user_data", package = "coder")
  stopifnot(dir.exists(user_path))

  structure(list(name = user_name,
                 path = user_path),
            class = "coder.user")
}
