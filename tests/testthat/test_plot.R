library(magrittr)

context("plot.R")

# cases
two_diverging_edges <- create_system() %>%
  node("load balancer", 0.9) %>%
  node("web server", 0.9, 2)

two_converging_edges <- create_system() %>%
  node("load balancer", 0.9, 2) %>%
  node("web server", 0.9)

both_diverging_and_converging <- create_system() %>%
  node("load balancer", 0.9, 2) %>%
  node("web server", 0.9) %>%
  node("database", 0.9, 2)


test_that("format_node_names()", {

  expect_equal(two_diverging_edges %>%
                 format_node_names(),
               c("load balancer", "web server 1", "web server 2"))

  expect_equal(two_converging_edges %>%
                 format_node_names(),
               c("load balancer 1", "load balancer 2", "web server"))

  expect_equal(both_diverging_and_converging %>%
                 format_node_names(),
               c("load balancer 1", "load balancer 2", "web server", "database 1", "database 2"))
})


test_that("format_from_nodes()", {

  expect_equal(two_diverging_edges %>%
                 format_from_nodes(),
               c("load balancer", "load balancer"))

  expect_equal(two_converging_edges %>%
                 format_from_nodes(),
               c("load balancer 1", "load balancer 2"))

  expect_equal(both_diverging_and_converging %>%
                 format_from_nodes(),
               c("load balancer 1", "load balancer 2", "web server", "web server"))
})


test_that("format_to_nodes()", {

  expect_equal(two_diverging_edges %>%
                 format_to_nodes(),
               c("web server 1", "web server 2"))

  expect_equal(two_converging_edges %>%
                 format_to_nodes(),
               c("web server", "web server"))

  expect_equal(both_diverging_and_converging %>%
                 format_to_nodes(),
               c("web server", "web server", "database 1", "database 2"))
})
