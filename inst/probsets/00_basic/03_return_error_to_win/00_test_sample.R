library(testthat)

test_that("testcase", {
  expect_true(class(input_param) == "numeric")
  test_function <- function(input_param) {
    stopifnot(mean(input_param) == mean(rev(input_param)))
  }
  expect_error(test_function(input_param))
})
