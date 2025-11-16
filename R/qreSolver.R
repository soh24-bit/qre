#' Title
#'
#' @param lambda
#' @param payoffs_p1
#' @param payoffs_p2
#'
#' @returns
#' @export
#'
#' @examples
solve_qre <- function(lambda, payoffs_p1, payoffs_p2) {

  n_p1 <- nrow(payoffs_p1)
  n_p2 <- ncol(payoffs_p2)

  qre_system <- function(x) {
    p1 <- x[1:n_p1]
    p2 <- x[(n_p1+1):(n_p1+n_p2)]

    # Expected payoffs
    exp_payoffs_p1 <- payoffs_p1 %*% p2
    exp_payoffs_p2 <- t(payoffs_p2) %*% p1

    # QRE equations for Player 1 (first n_p1-1 strategies)
    # p_i = exp(lambda * EU_i) / sum(exp(lambda * EU_j))
    f_p1 <- numeric(n_p1 - 1)
    denom_p1 <- sum(exp(lambda * exp_payoffs_p1))
    for (i in 1:(n_p1-1)) {
      f_p1[i] <- exp(lambda * exp_payoffs_p1[i]) / denom_p1 - p1[i]
    }

    # QRE equations for Player 2 (first n_p2-1 strategies)
    f_p2 <- numeric(n_p2 - 1)
    denom_p2 <- sum(exp(lambda * exp_payoffs_p2))
    for (i in 1:(n_p2-1)) {
      f_p2[i] <- exp(lambda * exp_payoffs_p2[i]) / denom_p2 - p2[i]
    }

    # Probability sum constraints
    f_sum_p1 <- sum(p1) - 1
    f_sum_p2 <- sum(p2) - 1

    c(f_p1, f_p2, f_sum_p1, f_sum_p2)
  }
}

