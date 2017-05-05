library(testthat)

test_that("testcase", {
  res <- capture.output(pyramid(3))
  expect_true(all(length(res) == 3, # To avoid character(0) passes all function
                  res == c("*", "**", "***")))

  res <- capture.output(pyramid(5))
  expect_true(all(length(res) == 5, # To avoid character(0) passes all function
                  res == c("*", "**", "***", "****", "*****")))
})
