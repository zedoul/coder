context("prob")

test_that("prob", {
  probset_name <- "level1"
  prob_name <- "01_helloworld"
  .prob <- prob(probset_name, prob_name)
  expect_equal(is.null(.prob), F)
  expect_error(prob(probset_name,
                    prob_name,
                    "/asdfdsf/dsfsd/asfdsdfsdf/sdfsdfsf"))
})
