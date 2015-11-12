library(magrittr)
library(reliability)

node(name = "load balancer", reliability = 0.90)

node(name = "load balancer", reliability = 0.90) %>%
  node("web server",  0.90) %>%
  reliability()

node(name = "load balancer", reliability = 0.90) %>%
  parallel(
    name = "web servers",
    components = node(name = "web server", reliability = 0.90) %>%
      reliability(),
    n = 2) %>%
  reliability()
#
#
# library(dplyr)
# library(ggplot2)
#
# expand.grid(
#   components = c(1, 2, 3, 5, 10, 30),
#   component_reliability = seq(0, 1, 0.1)) %>%
#   tbl_df %>%
#   group_by(component_reliability, components) %>%
#   summarise(system_reliability = 1 - nodes(
#     name = "system",
#     reliability = component_reliability,
#     n = components) %>%
#       prob_of_failure()) %>%
#   ggplot(aes(x = component_reliability,
#              y = system_reliability,
#              colour = factor(components))) +
#   geom_line() +
#   coord_cartesian(ylim = c(0.99, 1),
#                   xlim = c(0.995, 1)) +
#   geom_hline(yintercept = 0.95)
#
#
