library(magrittr)

# A simple series
nodes(name = "load balancer", reliability = 0.90, n = 1) %>%
  nodes("web server",  0.90, n = 3) %>%
  nodes("database", 0.90, n = 2) %>%
  prob_of_failure()

