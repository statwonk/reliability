context("components.R")

test_that("component()", {
  expect_error(component())
  expect_is(component(0.2), "numeric")
})