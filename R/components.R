#' Title
#'
#' @param ...
#'
#' @return list
#' @export
#'
parallel <- function(system = NULL, name, components, n) {
  if(is.null(system)) system <- list()

  failures <- lapply(rep(components, n),
                     function(x) { 1 - unlist(x) })

  system[[name]] <- ifelse(
    length(failures) > 1,
    { 1 - do.call(prod, failures) },
    { 1 - unlist(failures) })

  return(system)
}

#' Node
#'
#' @param item
#' @param name
#' @param exp_time_to_failure
#'
#' @return list
#' @export
#'
nodes <- function(item = NULL, name, reliability, n) {
  if(is.null(item)) item <- list()
  for(i in 1:n) {
    item[[paste(name, i, sep = "_")]] <- reliability
  }
  return(item)
}

#' Node
#'
#' @param ...
#'
#' @export
#'
node <- function(...) {
  nodes(..., n = 1)
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
  list(
    ifelse(length(reliabilities) > 1,
           { do.call(prod, reliabilities) },
           { unlist(reliabilities) })
  )
}
