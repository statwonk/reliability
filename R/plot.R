
#' Plot
#'
#' @param x
#'
#' @export
#'
plot.reliability_graph <- function(x) {

  #   x <- create_system() %>%
  #     node('load balancer', 0.9)

  graph <- create_graph() %>%
    add_node_df(create_nodes(format_node_names(x)))

  if(length(x) > 1) {
    graph <- graph %>%
      add_edge_df(create_edges(from = format_from_nodes(x),
                               to = format_to_nodes(x)))
  }

  graph %>%
    render_graph()
}

#' Extract node structure
#'
#' @param x
#'
#' @export
#'
node_structure <- function(x) sapply(x, FUN = function(x) { attr(x, "nodes") })

#' Vectorize edges from nodes
#'
#' @param x
#'
#' @export
#'
format_from_nodes <- function(x) {
  if(all(node_structure(x) == 1)) {
    node_names <- sapply(x, function(x) { attr(x, "name") })
    return(node_names[-length(node_names)])
  } else {
    for(i in 1:length(x)) {
      attr(x[[i]], "edges_out_per_node") <- ifelse(
        i == length(x), 0,
        node_structure(x)[[i + 1]])
    }
    return(unlist(
      sapply(1:length(x),
             function(i) {
               if(attr(x[[i]], "nodes") == 1) {
                 rep(attr(x[[i]], "name"), attr(x[[i]], "edges_out_per_node")*attr(x[[i]], "nodes"))
               } else {
                 if(attr(x[[i]], "edges_out_per_node") == 0) {
                   NULL
                 } else {
                   sort(rep(paste(attr(x[[i]], "name"), 1:attr(x[[i]], "nodes")), attr(x[[i]], "edges_out_per_node")))
                 }
               }
             }))
    )
  }
}

#' Vectorize edges to nodes
#'
#' @param x
#'
#' @export
#'
format_to_nodes <- function(x) {
  if(all(unlist(node_structure(x)) == 1)) {
    node_names <- sapply(x, function(x) { attr(x, "name") })
    node_names[-1]
  } else {
    for(i in 1:length(x)) {
      attr(x[[i]], "edges_in_per_node") <- ifelse(
        i == 1, 0,
        node_structure(x)[[i - 1]])
    }
    return(unlist(
      sapply(1:length(x),
             function(i) {
               if(attr(x[[i]], "edges_in_per_node") == 0) {
                 NULL
               } else {
                 if(attr(x[[i]], "nodes") == 1) {
                   rep(attr(x[[i]], "name"), attr(x[[i]], "edges_in_per_node")*attr(x[[i]], "nodes"))
                 } else {
                   rep(paste(attr(x[[i]], "name"), 1:attr(x[[i]], "nodes")), attr(x[[i]], "edges_in_per_node"))
                 }
               }
             }))
    )
  }
}

#' Vectorize node names
#'
#' @param x
#'
#' @export
#'
format_node_names <- function(x) {
  unlist(
    sapply(x, function(x) {
      if(attr(x, "nodes") == 1) {
        attr(x, "name")
      } else {
        paste(attr(x, "name"), 1:attr(x, "nodes"))
      }}, simplify = FALSE))
}
