context("components.R")

test_that("node()", {

  # helpers that apply to multiple cases
  is_structured_correctly <- function(x) {
    expect_is(x, "reliability_graph")
    expect_is(x[[1]], "numeric")
  }

  # tests
  expect_error(node())

  single_node <- node(name = "web server", reliability = 0.8)

  is_structured_correctly(single_node)
  expect_equal(as.vector(single_node[[1]]), 0.8)
  expect_equal(attr(single_node[[1]], "name"), "web server")
  expect_equal(attr(single_node[[1]], "nodes"), 1)

  two_nodes_in_parallel <- node(name = "load balancer", reliability = 0.9, n = 2)

  is_structured_correctly(two_nodes_in_parallel)
  expect_equal(as.vector(two_nodes_in_parallel[[1]]), 0.99)
  expect_equal(attr(two_nodes_in_parallel[[1]], "name"), "load balancer")
  expect_equal(attr(two_nodes_in_parallel[[1]], "nodes"), 2)

})