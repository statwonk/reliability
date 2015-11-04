library(magrittr)

# A simple series
node(name = "load balancer", reliability = 0.90) %>%
  node("web server", 0.90) %>%
  node("database", 0.90) %>%
  prob_of_failure()



