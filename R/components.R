component <- function(expected_failure_at) {
  rexp(1000, 1 / expected_failure_at)
}

prob_of_failure <- function(x, at) {
  1 - exp(-1*(1 / mean(x)) * at)
}

prob_of_survival <- function(x, at) {
  1 - prob_of_failure(x, at)
}
