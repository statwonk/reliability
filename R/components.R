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
node <- function(item = NULL, name, reliability) {
  if(is.null(item)) {
    item <- list()
  } else {
    item <- copy(item)
  }

  item[[name]] <- reliability
  item
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
