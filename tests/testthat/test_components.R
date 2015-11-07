context("components.R")

test_that("nodes()", {
  expect_error(nodes())

  ws <- nodes(name = "web server", reliability = 0.8, n = 2)
  expect_is(ws, "list")
  expect_is(ws[[1]], "numeric")
  expect_equal(ws[[1]], 0.8)

  library("magrittr")
  expect_equal((ws %>% reliability())[[1]], 0.64)

  single_node <- node(name = "web server", reliability = 0.8)
  expect_equal(single_node[[1]], ws[[1]])

  always_fails <- node(name = "web server", reliability = 0)
  expect_equal(always_fails[[1]], 0.0)

  always_suceeds <- node(name = "web server", reliability = 1)
  expect_equal(always_suceeds[[1]], 1.0)
})