copy <- function(series) {
  series <- lapply(series, FUN = identity)
  class(series) = "series"
  series
}

component <- function(item, name, exp_time_to_failure) {
  item <- copy(item)
  item[[name]] <- rexp(1e4, 1 / exp_time_to_failure)
  item
}

prob_of_failure <- function(x, at) {
  1 - exp(-1*(1 / mean(x)) * at)
}

prob_of_survival <- function(x, at) {
  1 - prob_of_failure(x, at)
}

series_prob_of_failure <- function(data, by) {
  d <- lapply(
    data,
    FUN = function(x) {
      prob_of_survival(x, by)
    }
  )

  if(length(d) > 1) {
    return(1 - do.call(prod, d))
  } else {
    return(1 - unlist(d))
  }
}
