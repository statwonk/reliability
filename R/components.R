#' Create a system
#'
#' @param named
#'
#' @return list
#' @export
#'
create_system <- function(named) {
  reliability_graph <- list()

  attr(reliability_graph, "class") <- "reliability_graph"

  return(reliability_graph)
}

#' A series of nodes
#'
#' @param item
#' @param name
#' @param exp_time_to_failure
#'
#' @return list
#' @export
#'
node <- function(graph = NULL, name, reliability, n = 1) {
  if(is.null(graph)) graph <- list()

  reliability <- 1 - prod(rep(1 - reliability, n))
  graph[[length(graph) + 1]] <- reliability

  return(graph)
}

#' Reliability
#'
#' @param reliabilities
#'
#' @return list
#' @export
#'
reliability <- function(reliabilities) {
  # recall reliability aka "survival" is 1 - P(failure),
  # hence F1 + F2 - F1 * F2 <=>
  # 1 - (1 - F1)(1 - F2) <=>
  # 1 - S1 * S2 where S indicates a survival function.
  prod(unlist(reliabilities))
}

