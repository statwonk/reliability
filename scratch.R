library(magrittr)
library(reliability)
library(DiagrammeR)

create_system() %>%
  node("load balancer", 0.9) %>%
  node("database", 0.9) %>%
  node("web server", 0.9) %T>%
  plot() %>%
  reliability()



create_graph() %>%
  add_node_df(create_nodes(c('Internet', 'Load Balancer', 'Web Server'))) %>%
  add_edge_df(create_edges(from = c('Internet', 'Load Balancer'),
                           to = c('Load Balancer', 'Web Server'))) %>%
  set_node_attr('Internet', 'shape', 'plaintext') %>%
  set_node_attr('Load Balancer', 'reliability', 0.8) %>%
  set_node_attr('Web Server', 'reliability', 0.9) %>%
  render_graph()

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
