context("components.R")

test_that("component()", {
  expect_error(component())
  expect_is(component(0.2), "numeric")
})

context("failure rates")
test_that("prob_of_failure()", {
  expect_error(prob_of_failure())
})