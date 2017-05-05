\name{Throw Error to Win}
\alias{throw_error_to_win}
\title{Throw Error to Win}
\description{
Give numeric vector to throw error
}
\usage{
# Any numeric class value to win
input_param <- 1:5
}
\examples{
# Test case 1/1:
input_param <- "???"
expect_true(class(input_param) == "numeric")
test_function <- function(input_param) {
  stopifnot(mean(input_param) == mean(rev(input_param)))
}
# It should throw error
expect_error(test_function(input_param))
}
