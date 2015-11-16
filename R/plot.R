plot.reliability_graph <- function(x) {
  print(
    create_graph() %>%
      add_node_df(create_nodes(names(x))) %>%
      add_edge_df(create_edges(from = names(x)[-length(names(x))],
                               to = names(x)[-1])) %>%
      render_graph()
  )
}