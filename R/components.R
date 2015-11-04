#' Copy series forward
#'
#' @param series
#'
#' @return "series"
#' @export
#'
copy <- function(series) {
  series <- lapply(series, FUN = identity)
  class(series) = "series"
  series
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
nodes <- function(item = NULL, name, reliability, n = 1) {
  if(is.null(item)) {
    item <- list()
  } else {
    item <- copy(item)
  }

  for(i in 1:n) {
    item[[paste(name, i, sep = "_")]] <- reliability
  }
  return(item)
}

#' Probability of failure
#'
#' @param data
#'
#' @return numeric
#' @export
#'
prob_of_failure <- function(data) {
  if(length(data) > 1) {
    return(1 - do.call(prod, data))
  } else {
    return(1 - unlist(data))
  }
}
